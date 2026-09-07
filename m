Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D8B3537E5
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796756; cv=none; b=ZlOTl+LVFr1Sp6tf/kkU6BoKlTjLNOwP54Beia7XhGQqRZb/EvvZqZ8ckRi+3BOyxIXjs9r97lQdtd7fLr0G0Dqjv2R89dVdx/R1agzswDa+uVYLlxC0M17b/642ijP1+LxLC7BSAulbKzRW8PC6gjH7Zl1wKs7zzWy+69NkfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796756; c=relaxed/simple;
	bh=wUEIL7VoWm6sWHD+ZViWxNXwM4BP7GRQp8vE/tW9rMU=;
	h=Message-Id:References:Content-Type:Content-Disposition:Cc:From:
	 Subject:Mime-Version:To:In-Reply-To:Date; b=TIyrfBeWIuaWa7cdnkq2FA41/3/SAvJFmmd1SYg8xt5wF50mmHJwGMJVGJO+WHxvmvpxmqiHVADZ4RmLWA+lVy853BhDCtXJeyWzzNNCVDqxR3KNpJ/XMoXgdGjwwcBCDPVTAeJsMK6InmkWBuyZV8rbz/Le8TZBrwjlkfKY3z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=r0LrwAnn; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="r0LrwAnn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1788796740; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=M8/WI6AJeSmvEUTgCg9I0OUNh2rq2++od/Uz13Erlf0=;
 b=r0LrwAnnVwrDqdKZt88mDsSiChw/sNqErmbwcYw+6FO/za7fp9DTZyVxysalixLBdOqk8L
 eFhO3wLpLdfjO3P5Rec3MD5q/tiZD1qNHKDs/ZVG5qJesvkHjcol1PYMqh5SYaD9hCCc3U
 m0PCIbiytwgyDiNpjtfe66hGrpLT6kXSdNtFM2473Zz06DPTONhdRdoa7chvIATbTLlUj8
 ggHAIM7kFrn9ICBeiAaR/79aDCXFyU8kyTZsk2LqA1KdFXDe+NjrzB65DZm/Cx8zu1fBH2
 201mJdMdzhxlMq0T39N8UbF6jJpVhjHB6TLKmy1SQQH16rZYdurkSt4SVlwx1g==
Message-Id: <ap7fP5Lz04kySgn9@pve>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Lms-Return-Path: <lba+26a9edf43+f9605b+vger.kernel.org+me@cherr.cc>
Received: from pve ([111.42.148.75]) by smtp.feishu.cn with ESMTPS; Mon, 07 Sep 2026 23:58:58 +0800
References: <20260904105542.70540-1-phucduc.bui@gmail.com> <20260906131711.247708-1-horms@kernel.org> <CAABR9nFYrmteCtb6E_txg13U31Bf50p0PUBvaOXi3gmT7Z+0RQ@mail.gmail.com> <GV2PR04MB1173965A34420E072C0DD3A1988B22@GV2PR04MB11739.eurprd04.prod.outlook.com> <CAABR9nHUXPL8dV8iqJ-x4OWRLw-qRm8MTq_QDTEJ94WhLWRiqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Cc: "Wei Fang" <wei.fang@nxp.com>, "Simon Horman" <horms@kernel.org>, 
	"Frank Li" <frank.li@nxp.com>, "Shenwei Wang" <shenwei.wang@nxp.com>, 
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"davem@davemloft.net" <davem@davemloft.net>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"kuba@kernel.org" <kuba@kernel.org>, 
	"pabeni@redhat.com" <pabeni@redhat.com>, 
	"richardcochran@gmail.com" <richardcochran@gmail.com>, 
	"swboyd@chromium.org" <swboyd@chromium.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"Shengzhuo Wei" <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: Re: [PATCH net v3] net: fec: Propagate PTP initialization errors
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Bui Duc Phuc" <phucduc.bui@gmail.com>
In-Reply-To: <CAABR9nHUXPL8dV8iqJ-x4OWRLw-qRm8MTq_QDTEJ94WhLWRiqg@mail.gmail.com>
Date: Mon, 7 Sep 2026 23:58:55 +0800

On 2026-09-07 09:28, Bui Duc Phuc wrote:
> Oh, great! I see it now.
> 
> However, it looks like that patch does not fully address the root cause.
> 
> There are two places where devm_request_irq() is called:
> For PPS in fec_ptp_init().
> 
> In probe():
> devm_request_irq(&pdev->dev, irq, fec_enet_interrupt,
> 0, pdev->name, ndev);
> 
> The approach in that patch only handles the first case, so it does not
> fully solve the problem.
> 

Yes, my patch leaves the main Ethernet IRQs unchanged.

For PPS, it also addresses the handler racing with PHC teardown,
as discussed in your earlier thread. Clearing pps_enable does not
wait for a handler that has already passed the check. The explicit
devm_free_irq() waits for that handler before ptp_clock_unregister().

Moving the netdev allocation to devm would address the IRQ/netdev
freeing order, but by itself would not provide that synchronization
before PHC teardown.

For the probe failure case Simon pointed out, we also need to account
for the failed_reset path skipping fec_ptp_stop(). With the explicit
IRQ release in fec_ptp_stop(), applying both patches would still
leave that path without the early IRQ cleanup.

I am preparing v2 with fec_ptp_stop() moved after unregister_netdev(),
as Wei suggested for patch 1.

Are you planning a separate patch for the IRQ lifetime issue? I'd
like to coordinate so that we cover these paths without duplicating
the work.

Thanks,
Shengzhuo
