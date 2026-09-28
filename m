Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2C48F035
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790594626; cv=none; b=OkQsnNmE3GHMVsLd7num7k2tO8ewBig+xHshplTwHMioNPwy5qsYw+DvG5RrCJiUwOQFglZZvj9FNbH1RrqPH3b5WBWCEoEXR0hBz0IMEYDUme5KObqdDB+b1woQQ0MRyK0kFtxvRmw4rejiofcijCh9YGB8BibNIfeeh1o101Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790594626; c=relaxed/simple;
	bh=y3LG/oEMsYOKkvEz+prsL3huO8uzPU+cBqBzPjsZNVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffAZB3MD0VD6Tnv4ziEqzHEgYpjIMCu2VEyuiuKVUmC+ZD45Xr9S0SNMAMC9W62MPI2uUWJ60OQDYvhY88S6FQnc6eJZ/wm7LHU30MWw5I/86z/DVEbAQLZ+vg0lsYrV+TbfLcspzVnKE92pzfdc+MV3YVMeKkZ1YB/TNfAghI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QoFEH6N5; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QoFEH6N5"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0abca97c0so1445003a91.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790594624; x=1791199424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cWADQNfVJU7i393TaaUZJY2Nfyu6YLHN28EbnBIQY50=;
        b=QoFEH6N5LzUZdNeI53GWpc8/WxJEwbs00tAfkidhZTp0156X5fC8Aea9PdW05fXzcK
         g5b/cdpw2nH6sr1ZzOsknbPWYy1Y4Q52FU0aBiEC5wJL2allNuUctrSzfGhHuaCbXV9j
         X4jzgKVU2fXz5+b58R1Z8s0fQKifMEeFS+ti/gA/qCWRBCb7wBw4MEPX0m5Ik94wtj5Z
         ykwo6AdZHTmtYRf7ffpG5+q30dwqP+hAYo3VOIa6FP9IvT0o8HufqGKY2TUW8z2rz6Ow
         NkPEdXILMuNCiz/BplpOqgbtRSy59rr4hkAJX26G92aCxGOqO27tvWMeM+MFjSr/2rM6
         it0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790594624; x=1791199424;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cWADQNfVJU7i393TaaUZJY2Nfyu6YLHN28EbnBIQY50=;
        b=BZ4uT62tVtbjgodi9JgKlfxlpRU4S3SlerQzS31QLRy1kKYkUXvPAkM8CsUEOqXcFw
         NysMy2FToJ5rv1HsNThlpv4GzZE1kKDcUrKNRnEFTqDRMuCPdQ50CRIltn/SipJHXVt3
         Mv9OYkv3iYAx1o8vn2On3ZHBNcRh1Gqop5+TAHdmD0kYxkdDuEa67aHaJ2/GS+243zUX
         S6ymLHrrSjCIff3eC97WgIQEWo8hduTxBq2AIQcLcy3wXQFZj5ioMYsHNfPp9n6RiDCk
         K3Vx0Pvnyy8QUVe0WcHgd5sxc5z31efFJ8e0JitcSRTaXdw+vmd33ATUpmckzkINyiy5
         3Rcw==
X-Forwarded-Encrypted: i=1; AKwUvByWuHqBM6/l/IMwSMRKjki10zV5237eDx7ysWbJ1gH8dJlg1ZkTzbMGYpveRH2zPWpdpIKo8l8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQztM48sUE2V5DOBORede8QUZ0r0utmyFt8JDWeBP1GYA0k3Gb
	7DTkH7E8nTTIbpoV0VTqi6QoD0rKnalLd+t5jYiNIVuU4MW0RRBbTDcj
X-Gm-Gg: AYBFou0N/gVjTmU78O7pzF54N8ZxB/bSS6SLeR6JYWWTyqYEUWRCDfLAejw0sxzNIed
	FiLACewfh0TP0gcVLfsA+Ne/7omdmiznFguGYUplkBJEqftSfYVgbqA1xd7uEvEfLikro9FQe8M
	EoNXQScWDgdlYgZEjjaykakmRPiB1B39d9bqVZ2BbIswvYOcp9xoOBx1AggkRmEr07TY2P7EMMy
	o4g3sl44xbwllv6m2fyo7WRY8DsjC4ZIvkQ4B5UPW8Ho1FNssC7SIMDLfOib1rdP+MTObXK4W0D
	qI/dKF3sYvEENB/KnH0uJLxmHop/Otsppv0Fr4MMZkM57fqsm2a/pPCLe1KduVV8LPLHRObW2ej
	1GyWTak4T63j1v7yS0jsadWOZIijfR//f/7ezCb7JCRxzMoYInS1pOA1lMy+kjZsnkN5F0SdaM6
	TW7Md1IyYYkzp+iDC6N4Zz2I5HBP8D/Uim91OS0ESaMuJVZUTJ5D4HmyLfgiXFjasRhs5vif3g8
	JJDFI3XaChNxCWlcqI5IBw9G7fegxbx0FkOneRmPbCmyWYq6E96/3S0kZgqwjmlt8h5FGY+OBw0
	BwUcnWngWE7fUc7F
X-Received: by 2002:a17:90b:3c92:b0:3a4:7c19:6a0c with SMTP id 98e67ed59e1d1-3a47c196e00mr534135a91.31.1790594624049;
        Mon, 28 Sep 2026 04:23:44 -0700 (PDT)
Received: from [0.0.0.0] ([2406:da1e:f76:8d20:77ec:b3e7:5372:2d36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0cd1c4ec9sm16039801a91.16.2026.09.28.04.23.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 04:23:42 -0700 (PDT)
Message-ID: <785bffbc-b028-46dd-b3de-b95a28122258@gmail.com>
Date: Mon, 28 Sep 2026 19:23:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: John Crispin <john@phrozen.org>, Andrew Lunn <andrew@lunn.ch>
Cc: Ziyou Xu <xuziyougm@gmail.com>, netdev@vger.kernel.org,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>,
 Christian Marangi <ansuelsmth@gmail.com>, upstream@airoha.com
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
 <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
 <372bc103-e98f-486d-8dd2-f013b1dbbdcb@lunn.ch>
 <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <0077ab02-2215-4015-9e74-eeb8c3de6b14@phrozen.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi John,

Thanks, this is very useful, and Benjamin's follow-up also helps narrow
the problem.

Having working code changes the discussion considerably, but I would
still like to be careful not to make the boundaries of one working
Airoha implementation become the generic Linux model before we compare
them against another implementation.

Ziyou and I have started looking more closely at public PON software
from other vendors for exactly that reason.

The most useful non-Airoha prior art I have found so far is the
MaxLinear/Intel/Lantiq PON software:

   https://github.com/maxlinear/pon_net_lib

This is not the PON MAC/PHY driver itself.  It is a userspace
network-adaptation layer between the OMCI/service model and Linux
networking.

Its ChangeLog is interesting because it shows many of the same
boundaries we are discussing here.

For example, it contains support for GEM/T-CONT relationships,
VEIP/PPTP Ethernet UNI, Extended VLAN, hierarchical qdisc/QoS and
multicast, but implements much of the networking side using Linux
netlink, TC, qdisc and bridge mechanisms.

There are also some particularly relevant historical changes:

   - OMCI packets were classified and trapped to the CPU using a TC
     trap action;

   - functionality from a private pon_mcc_drv was moved towards
     standard kernel interfaces;

   - the old "OMCI Bridge" was removed;

   - their VLAN handling was changed when the corresponding VLAN action
     interface became available upstream.

The MaxLinear platform is not just an abandoned historical codebase,
either.  Their current prplOS profiles still build PON WAN images:

   https://github.com/maxlinear/mxl_prplos_profiles

So this looks like useful independent evidence that at least the
general direction

         userspace management model
                 |
         standard Linux networking
                 |
         PON-specific bearer mapping

is not unique to the Airoha architecture.

Realtek may become another useful comparison point, although it is not
ready yet as a clean reference implementation.

There is an active OpenWrt RTL9607C/RTL8198D bring-up:

   https://github.com/openwrt/openwrt/pull/20064

and separate community work has reported working GPON on RTL9602C and
GPON/Ethernet/HW offload on RTL9607F:

   https://github.com/Anime4000/RTL960x/discussions/474

However, the PON/OMCI side still has proprietary components and a lot
of reverse-engineering work, so I would not use it to define an ABI
today.

Broadcom BCM6858 is even less useful for this purpose at the moment:
the SoC/platform support is public, but I have not found a comparable
public PON MAC/PHY/OMCI implementation.

This makes your implementation particularly valuable, but it also
makes me want to distinguish two questions:

         does this model work well for Airoha?

and

         which parts of this model are actually generic PON concepts?

 > net/pon has a struct pon_dev for each PON MAC. It is not a netdev,
 > which is what Andrew described with the wiphy comparison. Userspace
 > talks to it by a device id, not an ifindex.

This looks like a good answer to the lower-level object question we
had just reached.

I would especially like to review:

         - pon_dev lifetime and ownership;
         - device-id allocation and namespace semantics;
         - relationships between pon_dev and service netdevs;
         - how multiple PON MACs are represented;
         - which state is considered generic versus driver-private.

I agree with Andrew that this is probably better than creating a
synthetic net_device merely to obtain an ifindex.

 > Andrew's mapper exists too. A classifier on the data netdev maps
 > VLAN and 802.1p to GEM ports. The core keeps the T-CONTs, the GEM
 > ports and these rules. It replays them after a link loss. Everything
 > above that is plain bridge, VLAN devices and tc. T-CONT scheduling is
 > an offloaded ets qdisc.

This is probably the part I would most like to compare against another
vendor.

I agree with the upper boundary:

         bridge / VLAN / TC
                |
           classified traffic
                |
              mapper
                |
           PON bearer

The new PON-specific operation is the mapping from Linux networking
state to a bearer; Linux does not need another PON-specific VLAN or
packet classifier.

What I am less sure about yet is ownership below that boundary.

In particular, why does the generic PON core need to own and replay
the T-CONTs, GEM ports and classifier rules, rather than having some
of that state owned by the driver or by the networking/offload objects
which created it?

Your hardware may require explicit replay after loss of activation,
while another implementation may retain the state in firmware, rebuild
it from userspace, or expose a different lifetime entirely.

This is exactly the kind of detail where a second hardware family
would help us determine whether the object belongs in net/pon or only
in the Airoha driver.

The old MaxLinear code may also be useful here as prior art.  Its
history contains both GEM/T-CONT objects and Linux TC/qdisc/netdev
integration, so comparing the lifetime and ownership model may expose
which assumptions are hardware-specific.

 > Service traffic uses normal netdevs. There is one data netdev, plus
 > GEM netdevs where a GEM port needs its own bridge port.

I like that this does not imply one netdev per GEM Port-ID.

I would like to understand the exact criterion for when a GEM becomes
a netdev, though.

If "needs to be a bridge port" is the criterion, then it would be
useful to document what Linux semantics that GEM netdev represents,
and whether the same service can also be represented purely through
the mapper without creating such a netdev.

 > Control is a single generic netlink family with a YAML spec. OMCI runs
 > in userspace, in a GPL daemon that sets up the PON objects over that
 > family and everything Ethernet over bridge, tc, ethtool and rtnetlink.

This is probably the part where seeing the YAML specification early is
most important.

One of the main reasons for this RFC was to avoid freezing a
vendor-specific interface and only later discovering that another PON
MAC cannot implement the same model cleanly.

So I would like to review the Generic Netlink schema together with the
object lifetimes rather than treat it as an already-established ABI.

Benjamin's follow-up also seems to support keeping the first version
small here.

There are MEs whose underlying data naturally comes from the kernel,
such as hardware counters, timestamps or optical telemetry, but that
does not necessarily mean that the G.988 ME itself needs to live in
the kernel.

The kernel can expose the primitive state through the appropriate
Linux interface and the userspace OMCI agent can translate that into
G.988 semantics.

That seems preferable to introducing an in-kernel ME framework until
we have a concrete ME which cannot reasonably be implemented that way.

 > On the OMCI transport I think Andrew is right that omci0 has to go.
 > Today it is an ARPHRD_NONE conduit used with AF_PACKET, which is an
 > interface that is not really an interface. Rather than add a new
 > address family, I would follow what hostapd and wpa_supplicant do.

I agree that this is now the most promising direction.

The AF_PACKET design was attractive mainly because it gave us packet
semantics and observability without inventing another API.

But if the PON Generic Netlink family already identifies the pon_dev,
then OMCI registration plus TX/RX over the same family avoids both a
synthetic omci0 and a new AF_OMCI address family.

I would still like observability to be a first-class requirement.

Does the planned OMCI netlink transport allow one or more listeners to
monitor the raw RX/TX OMCI PDU stream, independently of the daemon
which owns the active OMCI endpoint?

Being able to capture the actual OMCI exchange is important when
debugging OLT interoperability and vendor/private MEs.

I think libpcap/Wireshark integration can be solved separately from the
transport ABI, but we should make sure the kernel transport does not
make passive observation unnecessarily difficult.

 > If all of this sounds plausible, I can post an RFC series of the
 > subsystem within a week, together with a link to a git repository
 > with pon-tool.

Yes, please do.

If possible, I would prefer the initial RFC series to be deliberately
small: enough of pon_dev, the Generic Netlink/YAML model and one real
hardware consumer to review the abstraction, with the complete working
tree and pon-tool available separately in a repository.

That would let us review the generic object model without requiring
the whole working AN7581 implementation to be accepted as one unit.

Christian, John mentioned that you and Airoha have already been
working on this design for quite some time.  It would be very useful
to hear which parts of the current model you consider inherent to PON
and which parts were driven specifically by AN7581 hardware.

It would also help a lot if the design could be independently tested
by developers outside the existing implementation team.

If Airoha is willing to make a small number of AN7581/AN7583
EVK/reference boards and the necessary programming documentation
available, Ziyou and I would be interested in testing the RFC and
comparing it with the existing userspace implementation.

Procurement and any NDA required for register-level documentation can
of course be handled off-list.  For upstream review, though, it would
be very helpful if the interface-level hardware behaviour needed to
justify the Linux abstraction could eventually be documented publicly
or at least be publicly discussable.

If there is an Airoha engineer who is directly responsible for the
PON MAC/SDK side, please feel free to add them to the discussion as
well.

Thanks,
Gaoyang
