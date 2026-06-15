Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D783321A1
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781557698; cv=none; b=M0D5Dknb8MNbgHNUR86aQpJ4qw47tc7rtTawlRy/X+t/RPkPTIArQlX1aU+irQztpaMzYFU7D1+jPcaDVWJEsBnqVzTqAbr16b84QXlaPbMqbPnir+LAnTeVSL7zg/a53IfCB6hEw9kKGsJzLim0aJstpRHnqOJtUb4/tn1C20M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781557698; c=relaxed/simple;
	bh=NGNsWAA/Tsa0ED8cia2A4fclFKN2DlT+/BOKyDIPlRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IruhSGOHpbicc01h5nJMNdY22ZxxpM81/SYqlMYJABjG4Gkeqik1aY19P3LS5bkNPBQH4kpgaY5f3qHkVCGSjmFGXJORRtkxh58Q3XSZg40qNpCcBk3OnLW350tAk4LYMHFL222hQefVuT8TlPpSw77FHGJF0efNRZqTug1vLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7fN2kwK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7fN2kwK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833651F000E9;
	Mon, 15 Jun 2026 21:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781557696;
	bh=nwPY5sxidV+HneAo5T+YuNdDqTDcLOj7PezqyE2216s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j7fN2kwKM5QDInXAdorEDj6X5TNjLqkek72wIKjegtLXlFiUO+c27ilAqXEoa2qiZ
	 nxe+eOBLGQlDsp4BKVZ/FO/I12eE0oiyKwH2IMPfoQTgEGOAHyYhDEZ6+YJ1bwSpZx
	 XOJHeb9XuyzpwS3rrRwutsNywSQ5lrQofz1S8d2L0W+4qRW7ObzVD+UiTkKbiT1tZj
	 PdmcGYHXaDfkYLctqhI+sZhYpNMndcnWqG2tU2HMNytWz1MN1kk1fccBQqeT8/8wXV
	 52/J0mKo5V9Tu+OPC08WxJe8BTafiHY1gVLceFUhTrvhV2Mr8Y7riO5ddiRG1Lzhf3
	 4aWymDwIqXThg==
Date: Mon, 15 Jun 2026 14:08:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, davem@davemloft.net, yotam.gi@gmail.com,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bestswngs@gmail.com
Subject: Re: [PATCH net v2] psample: use nla_reserve() for PSAMPLE_ATTR_DATA
Message-ID: <20260615140815.7543fd29@kernel.org>
In-Reply-To: <20260614034919.918494-1-xmei5@asu.edu>
References: <20260614034919.918494-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Jun 2026 20:49:19 -0700 Xiang Mei wrote:
> psample_sample_packet() open-codes the PSAMPLE_ATTR_DATA attribute and
> reserves nla_total_size(data_len) bytes but only writes NLA_HDRLEN +
> data_len of them.  When data_len is not a multiple of 4 the trailing
> alignment padding is left uninitialised, leaking stale slab memory to
> every listener on the PSAMPLE_NL_MCGRP_SAMPLE multicast group.
> 
> Use nla_reserve(), which lays out the header and zeroes the padding, and
> copy the payload into the reserved area with skb_copy_bits().

Use the diff I provided or I will post it myself.
