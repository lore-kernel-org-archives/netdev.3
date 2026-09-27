Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D572F8EAA
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550688; cv=none; b=Oxv0QK0IOpM/uPPaZt21G5GwZbDHyx0qxfDInUreWAJP1NVLB7hOErVVoRNPDbOb5+MhidCCFH/Ma5j4JroKET6gG1CJXjjG0h0k2xLIJLB35JkhOSoS8B4T/PT5Ij5wYTrOyIWgzbft6XfkXDUHghEHgEOtHM6MXK8+xfBIkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550688; c=relaxed/simple;
	bh=M7iuh3X+5ntSe8d0YDs2vqOC1YfZ5OnjexSr4Alxauo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abFT+LuEsJCIwpl3PhNyyR+2NaCjpgiUvPCGt5nBYvsLS3vuxSIFP14X60iE0z+AVvRZaQoH9iz0erX4GL5aPz4PieWbePYUSram+q5rKqMhyq5gI6QkzQA18AP17TlFMCYTe3soLRRw4zceTX8iOM78L/FUoYEAA5/fr3Fbci4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bEh+TYRt; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bEh+TYRt"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-3a0b0fa2055so1419481a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 16:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790550686; x=1791155486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fUuE+vPdSF3246lNZXLMovmF0LX7x0ib6mNhkCJDNGg=;
        b=bEh+TYRtipd2JgY3rXMDNJyg94yM2lQVceuOg3mHpOuMVb3Jc/dd1OQdRrvHbbzGSt
         7ak/bidKHMNG99wiRnQLusw+2ADhCTH/1PHt8XRQ48B++LQPoa8J4aANPCkyYzKgUoNo
         UR/519jJ81GYrxKqZnmY6Uma/WC3ZgU3MSnhVaIsevOCKKq+w6OlLKU8cegjZgrO47ib
         VCE/BX+v+NojFc/h8B5ODtazVAtPrU2XlHKIsueFPWgnwAOnNTPPAB/iYZfs4fQAfF2l
         TbpIr3JGL7o9fUk1FuNPALBxglNvZ1ZjezwZ46kZol/VVDzxQ1gJ45QD7FGqR3TOE4if
         diYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790550686; x=1791155486;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUuE+vPdSF3246lNZXLMovmF0LX7x0ib6mNhkCJDNGg=;
        b=koEUISB1xtASRWjzmN5dvK6i2gO4xqykYEN+5RI4dTrstv+rnHGdi4h+m4BSfsO1r9
         TwJ/gKrgVClh2w7/DOCfdEmJH9wcs1WwG68qy895SdmNaiO4V4p68aGBX5evmtrsnpxX
         BsFNVspiQdNrYtxCu6TlFGfoHMMv79i5SsYifWISRGxyKVFi3tAVTDIoyAVZT9Gjyc/S
         a7ysGHdrcsTc1p0hADgouVNyqCP7IC4ovtI6Io3dqxCOA44txFQQCt5zF8KEVt2rGoWx
         NranRunfPSoX7k+JQZCOJeCSPTgW5piuRnlC5FY84Obkn1WJ1SNeDUA//16WVfLyvvng
         TVAQ==
X-Gm-Message-State: AFq9FYLNuV9N+C5tXx2ZCdV/FDp+bWzcoi+emj0P3IxHyNcJIPYA8uT1
	MShKg5GWPz+oV/EAKk9HBvgybMwCP5h2d+g5QRRP7GHuUV74caPKtse7
X-Gm-Gg: AYBFou0YnASJa8a6IMpd/KgqdBjDma3EOkN2TeypzD4EkHOmf5hSO8Hz9UHiQc7OArv
	EqlG7B/YaPyj8pR+E8ovKnhPV6hAfpEHxE+UlycVUBauXTLP8lrJrtyfG0Fng/t1NUiEv2LpJ4v
	lN1Y5PDKkf8GsYeOu0IUum9QuUulF48a7NDa2Wgf2NenYU5Wr5VCKDYkLiu8jN0+dPWIc5yLtpF
	egbqzJNEHns2r4N5vVu1CrWBnlFGZGF5HKNpymplCsaogO5LlOinAh4PKg2L4FXNEILp5AGB98P
	PvhNULYU1o+tjatlTMuINtXKyr8UeG3RYSt6/I/x20Cpcwg5eOnst47FrZ02fYYrTcEfaJpIuP3
	/unVcNwfkdaVJyzs5Jn6FQ92HhgR6eZQHRaIqA8RmirpBXIdzf3FzQCTOuNfutNzxAX0XY2x47w
	Vb6Q6hIQqQkm/saZE1Vy/rUO/1h+RALy3DGefFq6Sh2Yc2IKTqSFmeEe9Jbr1+ohtQ63r5AX5xp
	YVkNqL6Hb5FKRfWipWslE7evbfYLbKFeAvJUWBa0OS+TA1ziD7gXt/zJ+ea1xomBby6tbxiIyDO
	AUqkQg==
X-Received: by 2002:a17:90b:3888:b0:3a0:cc33:2287 with SMTP id 98e67ed59e1d1-3a0cc3324ccmr5625047a91.6.1790550686145;
        Sun, 27 Sep 2026 16:11:26 -0700 (PDT)
Received: from [0.0.0.0] ([2406:da1e:f76:8d20:77ec:b3e7:5372:2d36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976cacbesm23114853a91.13.2026.09.27.16.11.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 16:11:24 -0700 (PDT)
Message-ID: <86e368cd-9f5a-49cb-a798-0f26a661fc30@gmail.com>
Date: Mon, 28 Sep 2026 07:11:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Andrew Lunn <andrew@lunn.ch>, Ziyou Xu <xuziyougm@gmail.com>
Cc: netdev@vger.kernel.org, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
 <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
 <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <e17ad80f-f2f8-4776-9f8b-1b7d3407c438@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

 > Another question which might affect the architecture. From what you
 > have described, an ONU might be assigned multiple Port-IDs so it can
 > carry multiple, separated, service traffic streams? You would want to
 > represent each stream as a Linux netdev, with its own IP addresses
 > etc.

An ONU can indeed have multiple GEM Port-IDs, but I think there is one
important distinction here: a GEM Port-ID is not necessarily equivalent
to one Linux service interface.

G.988 has an interworking layer between the GEM connections and the
Ethernet-facing service.

For example, one Ethernet UNI can use an IEEE 802.1p mapper which sends
different priority classes to different GEM ports.  Bridge and VLAN
configuration can also make the relationship between Ethernet services
and GEM connections non-1:1.

Very roughly:

                       Ethernet UNI
                            |
                    bridge / mapper /
                      VLAN handling
                      /     |     \
                     /      |      \
               GEM port  GEM port  GEM port
                  100       101       102

So I think GEM Port-IDs are better viewed as PON bearer resources.

A Linux netdev should represent an actual service interface where that
is meaningful, rather than automatically creating one netdev for every
GEM Port-ID.

This is also why I was hesitant in the original RFC to make GEM ports
the central Linux object.  They are important hardware resources, but
the Linux service topology above them can be different.

 > This again made me think of 802.11 in Linux. I'm not too familiar with
 > it, but it has the concept of a wiphy, which represents the lowest
 > levels of the hardware. You can then instantiate clients & access
 > points on top of it, each being a linux netdev.
 >
 > [...]
 >
 > You might need something similar, an entity which represents the lower
 > levels of the ONU, and then you instantiate netdevs on top of it as
 > dictated by management.

I think this may be the missing abstraction.

It also fits very well with your AF_OMCI suggestion in the other mail.

When I originally thought about a packet-oriented OMCI interface,
SocketCAN was one of the models I had in mind: a non-Ethernet protocol
using the Linux networking stack and normal socket/packet tooling.

But your AF_OMCI suggestion makes me think I may have borrowed the
wrong part of that model.

With SocketCAN, can0 represents a real CAN interface, and PF_CAN
sockets operate on that interface:

         physical CAN controller
                  |
                can0
                  |
           PF_CAN socket binds
              to can0

The CAN protocol itself does not require creating another synthetic
interface next to can0.

Ziyou's current OMCI implementation effectively looks more like:

                   PON hardware
                   /          \
            Ethernet path     omci0
                                 |
                             AF_PACKET

where omci0 exists mainly to provide a packet endpoint for the
already-demultiplexed OMCI PDUs.

Putting your two suggestions together seems to lead to a cleaner model:

                      +------------------+
                      |    PON device    |
                      |  (wiphy-like)    |
                      +--------+---------+
                               |
                 +-------------+-------------+
                 |                           |
              AF_OMCI                 service interfaces
                 |                           |
           OMCI userspace             Linux net_device(s)
                                             |
                                    VLAN / TC / bridge
                                             |
                                       GEM mapping

The PON object would represent the common lower level: the PON MAC,
line/activation state, and its relationship with the optical frontend.

The service netdevs above it would represent actual Linux-visible
Ethernet services where needed.

The GEM/T-CONT resources would remain below that service abstraction.
They could still be managed or offloaded by the driver, but there
would not necessarily be one netdev per GEM Port-ID.

This also gives a much stronger reason for one of the original RFC
questions about whether Linux needs a struct pon_device or equivalent.

Initially I was thinking such an object might mainly be useful as a
container for PON-specific state and resources such as GEM ports and
T-CONTs.

A wiphy-like model suggests a simpler and more fundamental purpose:
represent the shared PON line/hardware itself.

The minimum object might therefore only need to represent things such
as:

         PON mode
         activation / line state
         associated PON MAC / driver
         associated optical frontend
         service-interface relationships
         management-protocol attachment points

without making the complete GEM/T-CONT/service graph part of the first
generic API.

That also seems to answer part of the question raised by your AF_OMCI
idea.

If OMCI is a protocol associated with this lower-level PON object,
then there is no need for a synthetic omci0 merely to obtain
AF_PACKET semantics.

Conceptually the receive path becomes:

              PON MAC
                 |
          GEM/XGEM demux
           /           \
    service bearer      OMCC
         |               |
  service mapping     OMCI PDU
         |               |
      netdev(s)        AF_OMCI

and TX follows the reverse path.

I would still avoid defining the AF_OMCI socket ABI at this point,
because one question remains: unlike can0, a wiphy itself is not a
net_device.

So if the PON parent is similarly a non-netdev object, AF_OMCI would
need some way to identify the PON object rather than simply binding to
a service-netdev ifindex.

I do not think that is a reason to create another synthetic net_device
just to obtain an ifindex, though.  It seems better to first decide
what represents the PON device, and then design the management
protocol attachment around that object.

Is that approximately what you had in mind with the wiphy analogy?

I think packet capture should be kept separate from this question as
well.  Good observability of OMCI traffic is still important for PON
interoperability debugging, but that does not require the OMCI
transport endpoint itself to be a net_device.

Thanks,
Gaoyang
