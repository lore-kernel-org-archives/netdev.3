Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9673BF660
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542690; cv=none; b=TOH6cDzlnF8+V5miAHV+DR1kAaCNg9dw1k8M0+px3S4vQL6UUulfi3/dYyL9IsicYx/74pCeZky1zyyS1xitpZtCmaqNxQ5V0nZpl+dCVa3TjEfd9y/3JOgdg1BMuSSeUj+dNZmopIW7uqJi9p8gcCw8E6c4XYDQMI5blgdcNXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542690; c=relaxed/simple;
	bh=yWsNcWGranlMDkVCWBO5MfWTF4NTNCEAboiZpkthYR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8Bbn2T6PJgahdLbojSgw+9eNlPPtLFCRkn384fCgpiuREOQmnzmEaA7h2FpN3+TllnEbdEWqVx5FjUCVFbZ08Ec5hJrYdKAklPedz52vkcOPQ76N9YYazALhn1MlaA1WsCujM53HURxh+LNJ0/uoOUqp+GC2TfGyIi3SUSdQuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTw2Jd+8; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTw2Jd+8"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bec20a6fso896476a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790542688; x=1791147488; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fcNfLueKeDnBI48niP7iT/+Dw7DNW7q1H/N1tEhhoFs=;
        b=nTw2Jd+8WayB0cj2xPKS4oFgiBzDsPjVBPuEwjA2e/Qlvr7U0vvxsa0dnqJ/nOtJ6N
         T3XTZpNzisA09qSJ+3MrX3bYCtMy/tj6VUpQR6Xu4eI2Jr2uGsWVpTl67axo/aAOJ/d0
         zC6srT/sw8QYuFw9Qjpgl4FdkMddL/T5bzr0VEfhknga3rQqwik9Uu73Qf4k1mGesPUw
         P89okD3Y2Nb81mm1iTSQFNKrbbQ/T8kmZAi0X/c77+XkmroZmfEHkwSg4s4UjpthZ7lm
         3R5M0wP7EUU4fvs++nw4aKvL9N7P9uDNy+KtJTcJeBFrx/UATXWnUGx07sFXnSWurYAA
         GMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790542688; x=1791147488;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fcNfLueKeDnBI48niP7iT/+Dw7DNW7q1H/N1tEhhoFs=;
        b=1rAxbKHmCAk16st7+SFm4Ms1Y2Lnmla0T9TMSCVS4a/+PEOpsRs1oL7vqpFXNGJUE7
         /bLvKYMsNS6buxannSR9o1qLqWzkTkTaVQPfB0gNBwmolvIgo7+GQmx+hHvpjLlyj+Q3
         NIr8eNd2jUR3KpukfVhDVxYnFddUhwJO2vjuitajgevXVVGCw1WhiofMIaHz1zVoganP
         tr1uCYPFQgpjkDA/md8RJ8wUnyskBB5Esz0/wCMczA+Glv2ixuM3lJCK6bgV5RM8yoQw
         4449QqfBK3anH3RTpdvgVuUvBgEHowDfPhFrg0EI5LqxQFsKTIPaH+rQ4V6I5/SkZ+PD
         hDzg==
X-Forwarded-Encrypted: i=1; AKwUvBxbpPPvonEorgiEzG5jsvi/rQTIk19iFKZzvQb3ooqkpXJnaEEZz75WpLabf/FotMbrb8HwApU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5hWQIzEb/pCB9M9+8G7DrSHlLLHaZEJcyFiAKC21stUcsCmZF
	A5oK72u9I1YqhDU3TsqIcJkZ0mdRAuXfAhqHaAJFYpMTh4FWo0yPcf0w
X-Gm-Gg: AYBFou3apsMuGqyoPeNKri1gOwmGhNFCVy2cwnRh1yP0WcxVjPXn+32igp8W7YVG1hc
	MQErNqa6ajDLg31pkyW9oikzo2AU6XqpvpkLTczRZoO0DFynqEuMhzOOuwNnPyRu26Rl51ZLhsw
	uX8Lw7oYokjFXCBkKEB28oiA/UgM6KgaphxaXdHJdNMPR8370Oc+4GxZP3GWMl6NZvMDQRtA3MK
	WsCQu1GCJbOrV8W0LEMM0+EbtZ/gfkAG18FMhFydai8BA27AVWlkhMzwhAxky5EXnd+Kll97j2U
	uy2d93zqdMOcxA+xNOEqA9iOtOAst1QKF1ik51slrVZ/dWaJPbtgGw3TVvKPl9/mIoOZXWmbLNM
	1PIrPv4I/R+kA89psHNUaBKTa/MehCktgGzdcL855/gFW376txRffORJr20jU/iI9Ezyo0lHke9
	U7TW3A6JkWND6LBFJ6ILaedAa97gqNQp/ue4OxDazpuTFc7pTG0bvNDI3hJKk1isPiEhdLKsw6i
	gXLV7Fv291/amEA/dgKBsxYSD5u1NNDdzp88QpYLd5AQt/CrbOMrP1E+jZ1UZlZBscCZlrzsklZ
	zbNfmfwxv2JeiZLywS7fwEc=
X-Received: by 2002:a17:90b:4acc:b0:3a0:e0a5:dbb7 with SMTP id 98e67ed59e1d1-3a0e0a5deb6mr2717991a91.35.1790542688122;
        Sun, 27 Sep 2026 13:58:08 -0700 (PDT)
Received: from [10.10.2.99] ([223.105.83.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a2b1e4d5basm4474283a91.9.2026.09.27.13.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 13:58:06 -0700 (PDT)
Message-ID: <1c86669e-1d47-484d-9ebd-f7d2dc6ed0d3@gmail.com>
Date: Mon, 28 Sep 2026 04:58:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Benjamin Larsson <benjamin.larsson@genexis.eu>, netdev@vger.kernel.org
Cc: pbs05 <xuziyougm@gmail.com>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <9135f26a-a692-4b7f-a7f4-3c243f1cb0e4@genexis.eu>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <9135f26a-a692-4b7f-a7f4-3c243f1cb0e4@genexis.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Benjamin,

Thanks, this is very helpful.

 > What is completely new is the omci part. And here I have come to the
 > opinion that some parts (MIBs) should be handled internally by the
 > kernel and some should/can only be handled by user space. Because of
 > that there needs to be some kind of api where you can connect the user
 > space version of the omci stack to the kernel level ploam transport
 > (gpon inband side channel).

I think this is an important point.

The more implementations we compare, the less convinced I am that the
generic framework should decide up front where the complete G.988
agent has to live.

The AN7581/AN7583 implementation keeps the G.988 model in userspace,
while Matheus has a largely in-kernel implementation, and what you
describe sounds like a hybrid model.

That makes me think the generic boundary should probably separate:

         PON MAC / activation / transport
                     |
              OMCI transport
                     |
         +-----------+-----------+
         |                       |
    in-kernel handling      userspace OMCI
         |                       |
         +-----------+-----------+
                     |
               GEM/T-CONT /
               service setup

rather than making "OMCI is in kernel" or "OMCI is in userspace" part
of the driver model itself.

In other words, perhaps the common part should expose the OMCC
transport and the hardware operations needed by OMCI, while allowing
the actual ME/MIB logic to be split differently by different
implementations.

 > Doing it this way gives the advantage of not needing an external omci
 > stack for some OLTs which is nice for development and testing purposes
 > amongst other things. But interoperability amongst OLTs is really bad
 > so there also needs to be a flexible way to just update the omci part
 > in case you really need to amend the omci logic.

This matches what we have been seeing as well.

I think the interoperability argument is particularly important here.
Even if a kernel implementation handles the common G.988 cases, there
needs to be a way to replace or extend the higher-level OMCI behaviour
without having to modify the kernel for every OLT/vendor quirk.

That also suggests that the kernel-facing API should operate on fairly
low-level semantic objects and raw OMCI messages, rather than exposing
the full G.988 managed-entity model as a stable UAPI.

 > The api also needs a way to monitor the messages sent back and forth to
 > be able to triage issues. This is a common issue in pon deployments.

Agreed.

This is also one reason we have been looking at a packet-oriented OMCI
endpoint.  Independently of the exact API, I think observability should
be treated as a first-class requirement.

For interoperability debugging we want to be able to inspect the
actual request/response sequence, including vendor-specific MEs and
unexpected result codes, rather than only seeing the final configured
state.

Andrew has raised the question of whether a dedicated management
net_device is the right abstraction, so we are discussing that
separately.  But I think your point means that whichever transport we
choose, it should have a natural way to observe the raw OMCI exchange.

 > The gpon mac data transport should expose an ethernet networking
 > interface but the model for the ploam transport does not need to be one.

I agree with that separation.

The normal service datapath should remain an ordinary Ethernet
net_device.

PLOAM is different: it belongs to the PON MAC state machine and does
not represent an Ethernet data path.

 > Does the kernel really need to handle all this? Is it not enough to just
 > handle the omci interface and data pass through? At least this is the
 > model we should have in an initial implementation.

I think this is probably a good way to reduce the scope of the first
RFC patch series.

Rather than immediately introducing generic kernel objects for every
T-CONT, GEM port, LLID and service relationship, an initial framework
could perhaps contain only:

         - a PON device / line object;
         - line mode and activation state;
         - the normal Ethernet service datapath;
         - the OMCI transport hook;
         - the optical frontend relationship.

Then T-CONT/GEM/LLID objects would only be added once we have a real
cross-driver operation which requires them.

That would avoid turning one vendor's internal resource model into the
generic Linux model too early.

 > Ploam is realtime and need fast handling of ploam messages, I have
 > observed link failures because of debug output printing to console,
 > handling it in generic code would risk exposing timing issues, it
 > belongs in the hardware mac driver that then should expose the omci
 > interface. That part should be common code.

This is very useful implementation experience.

I agree that the timing-sensitive PLOAM FSM should remain in the MAC
driver, especially if even printk latency can disturb activation.

What I would still like the generic layer to expose is only the stable
semantic state resulting from that FSM, for example:

         O1/O2/O3/O4/O5-like activation state
         ONU-ID assigned / not assigned
         OMCC available / unavailable
         loss of signal / loss of frame

rather than trying to implement the actual timing-sensitive PLOAM
message handling in common code.

Do you think that is a reasonable split?

 > Unfortunately the Econet/Airoha LDDLAs deviates from SFF-8472. So
 > regarding those one option could be to create a wrapper that makes them
 > look like a sfp module that you then could virtually plug into a port.
 > But later on I started to change my mind and that we should model them
 > what they really are. And that is as a BoB (Bi-Directional Optical
 > Sub-Assembly on Board).

I think modelling it as what it actually is is probably cleaner as
well.

The parts which already map to existing subsystems can still use them,
for example hwmon for optical telemetry and NVMEM for calibration,
without requiring the complete device to pretend to be an SFP module.

A small BoB/optical-frontend object could then provide only the
operations which are genuinely needed by the PON MAC, such as TX
enable, burst re-arm and optical state.

That seems preferable to synthesising SFF-8472 data which does not
really exist in the hardware.

 > I think a good way to start is with the dts and see how things end up
 > and then create a RFC around that.

I would be interested in what you would put into the initial DT model.

My current thought is that DT should describe hardware topology, for
example:

         PON MAC
           |
         xPON PHY
           |
         fixed BoB / LDDLA

plus calibration/NVMEM relationships and any fixed GPIO/regulator
connections.

I would be more cautious about putting ONU identity or operator policy
into DT, since values such as serial number, LOID, OMCI vendor ID or
OLT-specific profiles may come from NVMEM, be derived, or be supplied
by userspace.

If that is also what you mean by starting from DTS, then I think it
could be a useful way to establish the hardware object boundaries
before defining any UAPI.

So at the moment I am leaning towards an intentionally small first
step:

         driver-specific PLOAM / MPCP FSM
                      |
              minimal generic PON object
                      |
           +----------+----------+
           |                     |
      Ethernet data          OMCI transport
         netdev                  |
                                 |
                      kernel and/or userspace
                          OMCI implementation

with the optical frontend represented separately and existing Linux
subsystems reused where possible.

Does that match the boundary you have in mind?

Thanks,
Gaoyang
