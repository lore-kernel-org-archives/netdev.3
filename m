Received: from mta-102a.earthlink-vadesecure.net (mta-102b.earthlink-vadesecure.net [51.81.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AEE366DB9;
	Wed,  3 Jun 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.61.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780502030; cv=none; b=YbgXcIur2E+Hra4Ih/oFs2Y72d4IYQI5I7fCC3cEnvkaIqEpr3tmQd9QoegO+LXTJS6p6p6Z+cxf4SCNKRtjLSmROG3f4LvipoG0TUKEy8MkBiMmujNzwTwvnnTOLBgpkCBtDqhT/ioFsdaCATvxLccGUHg9anTLFtcBiMX3rg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780502030; c=relaxed/simple;
	bh=ALxcJ38/KI+nrcVbIPqgS4dMUa9NwXNjv6BfuH3JzpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5cGljRCBmE9c4WDW4rfUvx+9FEs65rhUaDOLGZPsLHBDm9SD08JCZAmtUFFZ91HX3jS3xUeqxca0ljkr3B5kYAUFruum2aCAtrO7bxs047Onzn1tS2QfDW4pNho3BMZCXE+l+q0qRur8psL3ZNdPCvrDGPV2OX9VgPFGzYinu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com; spf=pass smtp.mailfrom=onemain.com; dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b=YICi2Gl5; arc=none smtp.client-ip=51.81.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=onemain.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onemain.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=earthlink.net header.i=@earthlink.net header.b="YICi2Gl5"
DKIM-Signature: v=1; a=rsa-sha256; bh=ALxcJ38/KI+nrcVbIPqgS4dMUa9NwXNjv6BfuH
 3JzpQ=; c=relaxed/relaxed; d=earthlink.net; h=from:reply-to:subject:
 date:to:cc:resent-date:resent-from:resent-to:resent-cc:in-reply-to:
 references:list-id:list-help:list-unsubscribe:list-unsubscribe-post:
 list-subscribe:list-post:list-owner:list-archive; q=dns/txt;
 s=dk12062016; t=1780501072; x=1781105872; b=YICi2Gl5iYhscsf53vglN3e1/uy
 47bOrYvxRnFxVBXT+OeCjYp81fx+t3MmqW3+NwGq/yiY+Hrk3OuN4U/oI7IVTOKIaMfm7j3
 2yvczT/p84E+vIiHUH0+MPWMPfqeuMIQXMuh3lVH+dmGbHOKHb6ilMuhMV61AFx7MNIfsWG
 hCL6vjiuRgHFY8dwkFMmLSiRAe1SLMj6YJ2Gjp3huX8TMPZRGcfd6Mn46F3sFKRFVaSYGRn
 HoghF60O8PFLLqBrwm7Tu/JTKgHpzVwVFAgc3k+pV4oeGDIgtyw5SkTQ2X3D2Xq0xOwGyTe
 Lo/4/4uGZOsPXN0j0/SaixuKLDNvttw==
Received: from [192.168.0.23] ([50.47.159.51])
 by vsel1nmtao02p.internal.vadesecure.com with ngmta
 id c590d1c8-18b59c4657ae0029; Wed, 03 Jun 2026 15:37:52 +0000
Message-ID: <620a9c51-604b-4622-a9a3-40f6a54e7aa6@onemain.com>
Date: Wed, 3 Jun 2026 08:37:31 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: fix netdev leak in i40e_vsi_setup() error paths
To: Dawei Feng <dawei.feng@seu.edu.cn>
Cc: aleksandr.loktionov@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn, zilin@seu.edu.cn
References: <eb74ae1c-3027-42f5-ad5b-a6f2c2cd6a98@onemain.com>
 <20260603032822.763195-1-dawei.feng@seu.edu.cn>
Content-Language: en-US
From: Shannon Nelson <sln@onemain.com>
In-Reply-To: <20260603032822.763195-1-dawei.feng@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/26 20:28, Dawei Feng wrote:
> Hi Shannon,
>
> Thanks for the suggestion. I took a closer look at the cleanup paths, and
> I think the localized v1 fix is safer here.
>
> In particular, i40e_vsi_reinit_setup() has early failure paths that can
> reach i40e_vsi_clear() before unregister_netdev() is called. Moving
> free_netdev() into i40e_vsi_clear() could therefore free a
> still-registered netdev.
>
> So I plan to keep the current v1 approach for this fix, rather than moving
> free_netdev() into the common VSI teardown path.
>
> Best regards,
> Dawei

That sounds fine, thanks for looking.
sln

