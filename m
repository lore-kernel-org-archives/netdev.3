Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE993E317F
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789569705; cv=none; b=cTHHH0UCfdvhUSoTLQSy28WWHlwymtwzw/iCbsMZHP34zDleM54mQAJalWyqvdZ+O1uZa5SP1aWH8vmC40u8kp/jTtM1ZvQLYgkg1oOzfMVKEmV74ZEIMOlQgqzvLg7TduZM4jwA/LGTjyq7UpGQCf4k4ZXzrfrSPKuARKL955w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789569705; c=relaxed/simple;
	bh=cb3K9Wz4WKZ1USoHmEWKk9pFli7NXO9zvlB8t8wy3xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DLX4CCKsxKmX4Hb8r64M5pLYqdFeuCUWty3Maa0XYZKm8qB16w43FnkMr8YXF9w783WTLkutDdUGvV5jlIJNwU+5LfiK/UTnEwNHn3VZWyO9sPbznF9PyPqWZZnfx+djgqtNObAPTmz/VpAssw8sncwghs0qNq43tEecaJcYxsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjItntIL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjItntIL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0184F1F000FF;
	Wed, 16 Sep 2026 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789569704;
	bh=JMZc6BTWU0VD/eixJdALpvzLlqy4CkXpMmg9ILvfmgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TjItntILXQLRK9sHIRtjWKrQW/zMcQCa43dRQSXmX/GfP4mY4aANGyo20d7d/N+6y
	 ZvBB4OgT1RStoynml/jm1JWrwUt6OoijgWNUwjoMmJABpyBw2Zsid1mWhLJBT9hJdN
	 /2Cm7aySX/34OJQTDGsyUO7DXIhQRSvs2HjJP9KHnRi5+kYO/7xi7QmHpcN7aW5qTM
	 bR1I4iTST7TuwKKqwb7AqGSJuTXhclkTPAjcuocXpROwyADcGcxrKNQZAXlYsSczGM
	 IiVG7XmI7RoaMwT4lrsBVUhbs7fI7RCP767k5XgRnYbgWKE8SWYxXBOQO981l8j/YX
	 PaWq3Joilm9mQ==
Date: Wed, 16 Sep 2026 15:41:40 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next 2/4] ixgbe: add ixgbe_container_is_rx() helper
 and refine RX adaptive ITR
Message-ID: <20260916144140.GN51261@horms.kernel.org>
References: <20260915125538.3975870-1-aleksandr.loktionov@intel.com>
 <20260915125538.3975870-3-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915125538.3975870-3-aleksandr.loktionov@intel.com>

On Tue, Sep 15, 2026 at 02:55:36PM +0200, Aleksandr Loktionov wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Add an ixgbe_container_is_rx() helper to cleanly distinguish RX from TX
> ring containers inside ixgbe_update_itr().
> 
> Refine the RX-specific latency-detection path:
> 
>  - Replace the shared "packets < 4 or bytes < 9000" threshold with an
>    RX-specific check of "1..23 packets and bytes < 12112".  When that
>    condition holds, target 8x the observed byte count in the next
>    interval by computing avg_wire_size = (bytes + packets * 24) * 2,
>    clamped to [2560, 12800], and jumping directly to the speed-based
>    ITR calculation.  This provides finer-grained control over low-rate
>    RX latency workloads without affecting TX.
> 
>  - Remove the separate "no packets" special-case block.  When packets
>    is 0 it falls into the "< 48" branch.  The mode-tracking logic in
>    that branch is extended: fewer than 8 packets forces latency mode;
>    8..47 packets preserves the current mode.  This replaces the old
>    unconditional "add LATENCY flag from ring_container->itr" carried
>    over from the removed block.
> 
>  - Remove the adjust_by_size label and the associated "halve
>    avg_wire_size in latency mode" step.  The Rx latency path now
>    pre-calculates avg_wire_size independently and the bulk path no
>    longer needs the halving to compensate for incorrect thresholds.
>    Rename the jump target to adjust_for_speed to reflect its purpose.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

