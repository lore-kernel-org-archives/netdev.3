Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A85641D11C
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183655; cv=none; b=go1n/HeaSsu3h1e55KvWVdRL7UjSwse+o3lqBm5Pzt09FnZP8dOeFEBpCLWueaexBwttoPzKt3ICujNV0wouDV57ZgLTabftB0bZDOt2eCKPCdBlXsgQ7OFJBCnDgHap8HOkuxg7wL/WA4Et6z4Qg/cu7iTR6IssJJSdHT9xawc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183655; c=relaxed/simple;
	bh=P3Ju2Iyv1uzqyUNZMNHilUyoqPznUpTovnDJlz7qz+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZmYhzKbA5RXxwI49HjgRz9eW5/hJ70qBXG8Fq5LsAvqStGUy7F/6EEZXuTDWuYTTtmnqhoyICQd2thF/1WH+UZn2z+kkV+D2EJ4357nCyNsMfzux6pkQISjxfT2vZbER7+LE5t0NeLfgnSbnR84nTwM5IRSbaE0fkF77cvCxwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBA83EsZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBA83EsZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB2041F000E9;
	Mon, 27 Jul 2026 20:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785183650;
	bh=P3Ju2Iyv1uzqyUNZMNHilUyoqPznUpTovnDJlz7qz+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dBA83EsZZd1y/pl1ERJQvlaLG/J5zfmdr4oco409C6pa69GnrcvpyOoMom7V3/+tn
	 QKsg63ruhFag+MQW1tAi9SrfHOTBW/niGjyU1s3mBABZWLefgo6P4JIpXOwDXlAXLc
	 JqvJwWzhh3KdXd2/UGm08xseHCTxSUt9rkXiDYQB6ZV/Sd3waTspN+dgUugQbAaGvW
	 2qBagyFMmsxb2+boz8VbQkCVDysQg1gWZIipAQaXt3zipmZKRrBd/2R/jdIlEdFARG
	 I0bf/P1kfYbB9cpzztIPV5E220F0GmGEqBlz4FiFrDsZysTARKfq8ZPRaZ/BD5F1w2
	 +jkVnGWLOtDug==
Date: Mon, 27 Jul 2026 13:20:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Maciek Machnikowski <maciek@machnikowski.net>, netdev@vger.kernel.org,
 richardcochran@gmail.com, milena.olech@intel.com,
 willemdebruijn.kernel@gmail.com, andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH v7 net-next 2/3] netdevsim: Implement basic ptp support
Message-ID: <20260727132049.397d3d1d@kernel.org>
In-Reply-To: <20260727094344.GM418547@horms.kernel.org>
References: <20260720181113.3293-1-maciek@machnikowski.net>
	<20260720181113.3293-3-maciek@machnikowski.net>
	<20260727094344.GM418547@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 10:43:44 +0100 Simon Horman wrote:
> Simon says: I believe the issue raised below has already been discussed.

Rings a bell but I don't recall the conclusion ;D

Maciek, please fix or beef up the commit msg to explain your thinking
