Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625953BB101
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540948; cv=none; b=sbHUqAzIbCERb7/wEkuqx6NYIeYlY/Y48ezRqr3LNeGHzQsvWXyiWWgDYlt94/mL6Nl/KDeThhkQETd+8HBMpZvMM/CeOCtEpisLynApGCZ8s7BoE0W7Y26BRqvpJ/XD02ePpCZSMantoSIvahVixavJ/UK4YfZ+glFLUcioe9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540948; c=relaxed/simple;
	bh=uimwgWgCbR0REgLgwp3wuS1Xw+Cad+QfFXmC9ieLbU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ah3mpKQSou37VF+F/tMp65TuCJ3NM25BSjg3s8jxhhKl8mNHemVMzGjLU0xo32hGicHrjS6qfCTcqaDi8wgeXiNOWRbHs+k0Rb8xjEJm+amEMjZDb4uEwlDcmVpQ2cPW7YmfIF6jbKrOQ6ycoSf2dVIG+o+p3ho+3p1GCkfKc4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ae6sW6Db; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ae6sW6Db"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398a147688bso1741719a91.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790540947; x=1791145747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pB4wLZelBvf/SuASyVrN93WtBZ6eBs6k4R08upTMeqs=;
        b=Ae6sW6DbsPRZwUyb5323er5H1UO9m5zZOpTVOo1Y4g399WbHSAOwV2ApOuwR2ewy7w
         uc/TYrkqsQYvt36jPm+YpGs7roHY9W9bBJkghvrDqVAz6h8Tnlt8/hJwRbpTBLWEn1O2
         lCfCNUgZBHDanhZfH6mqocaSu9bRN5fbZ0y+N3MaRZ0zFnhjFSWxec+6y5Ds29PwiFNH
         vwkkLNH9Y/SAyG+Z1dbQNFu+j/Jr2UT48yg4Rty/cRBHyHWkpBxAlrffuoTxRx3Fki3M
         IYZ/b2hSEh9fc8PzbWfbbQmr8JTm3JEjPdZygxxGiBIpEM3D2l6XU163aHt3UK5GegzZ
         t/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540947; x=1791145747;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pB4wLZelBvf/SuASyVrN93WtBZ6eBs6k4R08upTMeqs=;
        b=xrZNPOKUaRLb0j8LUXd9RTbHH8cUjz3o25F0WYEriK9n7G1f2tSgE2vFFbkZxXcuhT
         o8BSpGD+vMU1MVPo3nImGTzT1/PCAQoHrW5DGF/mhvcbBiOJmrn10ZSprG5+vzhq9rYf
         kc9h5LrjMUzWVT2HcDFw/tXTvDRNsZfvvfjzR5lOTuwHX9FhZdti+U19iyxnzO48rJR5
         MqWa7umZr+CGzdKlmilLHO4ZYERUcmvfe7ndM1yD5EQhKopgzVFJIdsymzaR+mqz/RvI
         HRU3T1dBBdXPBMOmUFH0pDQRHNyGnbKi4XuH/WksVHxYgPfX3o4wpQu/Xkuk9rTBPIo4
         Kulg==
X-Gm-Message-State: AFq9FYI1bVlsnovPPxP1syY14g+OrEywXpj1cV6CDFw2riorn9qnCD8J
	XdShb2vh7J59k6Rh9isfRg5r98Xc8R4H27Yk8D/qI1qv6tG/F80eIu5r4ANF9xaZ
X-Gm-Gg: AYBFou2EUSMg+ed3EMoPn9KLtHzBsQV/3odZ6vPGYbqGTwCEMHmP29FU/h3g0IezFa6
	7Xs7/x/Cvw0u7J3mZ/SJvdXhN1ecDOzlwpBxTbPdyKHyCRGlFIkdoysgpvWAQ+f/RPGqS9GXZa7
	Lyu1EwGOWZ+6rz+DKN2dMxK1vf7rd50/0qupRiz/duMZmlMqtD0HE/8d6yzXlzO7sawZQ0tNHqw
	c0J99+OBFXae6acAOn/dglf6QiSxwPdgH2DPLZRL0dEF6jt086c9bL1giUMQhxbmOgNyNB6qGHR
	DtCat5HK7EmVLHSlS59cMN+dNtS99HKZazinTpxjdMp1JhQiuF4IHVKFiasa2U22DaDRtm8SiaB
	/HhD1M/UOSceJgoB7cimILFCX1Ymhy7IolAKExEDeFMk0YHerrDFQHK+sZZolUoZBAMoSfjC2Zk
	gc5aq1IXfOX5/quTvafkz0eAAXxQ1QHhsCzFtEprJ4MWU/xvB7gXa0mT+JPXaomPujB4YzGic=
X-Received: by 2002:a17:90b:4d85:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-3a098d9612fmr10221030a91.21.1790540946594;
        Sun, 27 Sep 2026 13:29:06 -0700 (PDT)
Received: from [172.18.0.1] ([104.28.240.133])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976c7435sm23350161a91.11.2026.09.27.13.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Sep 2026 13:29:06 -0700 (PDT)
Message-ID: <7a469037-1266-4ca3-904b-9e8117cce5e9@gmail.com>
Date: Mon, 28 Sep 2026 04:29:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Andrew Lunn <andrew@lunn.ch>, Gaoyang Wei <yhyxwgy@gmail.com>
Cc: netdev@vger.kernel.org, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <b0d1908c-a6f6-4c28-bb4f-b00644acacfc@lunn.ch>
 <92d9c8a9-ef43-45ce-a599-2c00d0a2fa61@gmail.com>
 <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
From: Ziyou Xu <xuziyougm@gmail.com>
In-Reply-To: <3d5e9f9f-09e0-41a2-aa3a-e3bcfcecbef3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

I think I skipped over an important layering detail in my previous mail.

An OMCI PDU does have its own protocol header, but on the wire it is 
carried inside the PON transport framing. That lower layer is also where 
the management channel is separated from normal user traffic.

A little terminology may help here.

The OLT (Optical Line Terminal) is the operator-side device, while the 
ONU (Optical Network Unit) is the subscriber-side device.

A PON is point-to-multipoint:

                          OLT
                           |
                     passive splitter
                    /       |       \
                  ONU1     ONU2     ONU3

Downstream traffic from the OLT is physically broadcast through the 
splitter to the ONUs.

Upstream transmission is shared in time. The OLT assigns transmission 
opportunities to individual ONUs, which then transmit optical bursts in 
their granted time slots.

For GPON, the transmission convergence layer is called GTC, and service 
traffic above it is carried using GEM, the GPON Encapsulation Method.

For XG-PON and XGS-PON, the corresponding layer is XGTC and service 
traffic is carried using XGEM.

OMCI is the ONU Management and Control Interface specified by ITU-T G.988.

OMCC is the ONU Management and Control Channel, the logical GEM/XGEM 
connection over which OMCI PDUs are transported.

PLOAM is another management mechanism at the TC/physical layer. It is 
used during activation for things such as ONU identification, ranging 
and assignment of transport resources. PLOAM and OMCI are separate 
protocols.

So, very approximately:

                  service plane        management plane

                   service SDU              OMCI
                        |                     |
                        |                  G.988 PDU
                        |                     |
                        +----------+----------+
                                   |
                               GEM / XGEM
                                   |
                               GTC / XGTC
                                   |
                               PON optical PHY

For GPON, a GEM frame starts with a five-octet header.

ITU-T G.984.3 defines it roughly as:

      bit
        0          11 12         23 24  26 27          39
        +-------------+-------------+------+--------------+
        |   PLI (12)  | Port-ID (12)| PTI  |   HEC (13)   |
        +-------------+-------------+------+--------------+
        |<---------------- 5 octets --------------------->|

        PLI       Payload Length Indicator
        Port-ID   GEM logical connection identifier
        PTI       Payload Type Indicator
        HEC       Header Error Control

and the frame is:

        +-----------------------+--------------------------+
        | GEM header, 5 octets  |       GEM payload       |
        +-----------------------+--------------------------+

The field relevant here is the Port-ID.

A GEM Port-ID identifies a logical connection; it is not an Ethernet 
port number. Normal service traffic is transported on service GEM 
Port-IDs, while the OMCC is transported on a GEM Port-ID assigned for 
management.

During GPON activation, the OLT configures the GEM Port-ID used by the 
OMCC through PLOAM.

A receive path can therefore look roughly like:

                     downstream GTC
                          |
                          v
                     +-----------+
                     | GEM engine|
                     +-----+-----+
                           |
                       Port-ID demux
                           |
                +----------+----------+
                |                     |
         service Port-ID         OMCC Port-ID
                |                     |
                v                     v
        service datapath          OMCI adapter
                                      |
                                      v
                                   OMCI PDU

XG-PON/XGS-PON use the same general idea with XGEM.

An XGEM header is eight octets:

      bit
        0       13 14 15 16        31 32        49 50 51        63
        +----------+-----+------------+------------+--+------------+
        | PLI (14) | Key | Port-ID(16)| Options(18)|LF|  HEC (13)  |
        +----------+-----+------------+------------+--+------------+
        |<--------------------- 8 octets -------------------------->|

Again, the Port-ID identifies the logical XGEM connection.

For XG-PON/XGS-PON, the OMCC is associated with a dedicated XGEM 
Port-ID, and the PON MAC/OMCI adapter can select and de-encapsulate 
those frames before passing the OMCI PDU further up.

So, regarding:

 > How can you tell apart a OMCI PDU from a user data PDU?

That distinction is normally made using the GEM/XGEM Port-ID before the 
OMCI implementation sees the packet.

Conceptually:

              optical stream
                   |
                GTC/XGTC
                   |
               GEM/XGEM
                   |
              Port-ID demux
                   |
              OMCC selected
                   |
         GEM/XGEM header removed
                   |
                   v
              raw OMCI PDU

The OMCI PDU itself also has its own protocol header.

For example, the beginning of a baseline OMCI message contains:

      bit
        0                    15 16       23 24       31
        +----------------------+-----------+-----------+
        | Transaction ID       | Msg type  | Device ID |
        +----------------------+-----------+-----------+
       32                    47 48                    63
        +----------------------+-----------------------+
        | ME class             | ME instance           |
        +----------------------+-----------------------+
        |                                              |
        |              message contents                |
        |                      ...                     |

The transaction identifier associates a command with its response. The 
message type identifies an OMCI operation such as Create, Delete, Set or 
Get.

The ME class and ME instance identify the Managed Entity being operated 
on. These can represent things such as the ONU itself, a T-CONT, GEM 
port, Ethernet UNI, VLAN configuration object, etc.

So when I referred to a "raw OMCI PDU", I meant something like:

         +-------------+----------------+-----+
         | OMCI header | OMCI contents  | MIC |
         +-------------+----------------+-----+

rather than:

         +-----------------+-------------+-----+
         | GEM/XGEM header | OMCI PDU    | ... |
         +-----------------+-------------+-----+

The GEM/XGEM framing has already been handled by the PON side before 
that point.

For AF_PACKET, what I had in mind was exposing this 
already-demultiplexed OMCI PDU.

Your point about protocol-specific capture headers is interesting as well.

Depending on the hardware, some information from the PON side may still 
be available after de-encapsulation. A small capture pseudo-header could 
carry things such as direction, the GEM/XGEM Port-ID, PON interface 
information, or a hardware timestamp where available.

That would be capture metadata rather than part of the OMCI PDU itself.

This also makes me wonder whether we need a Generic Netlink interface 
for the OMCI path at this stage.

If the immediate userspace requirement is simply transporting 
already-demultiplexed OMCI PDUs, AF_PACKET already provides a packet 
transport abstraction.

Without a packet endpoint, we would need to define equivalent RX/TX and 
packet-delivery semantics through another interface such as Generic 
Netlink. I am not yet sure what we would gain from doing that if the 
object crossing the boundary is simply an opaque OMCI PDU.

Other PON state could remain internal to the kernel or use existing 
subsystems until there is a concrete operation which needs an 
xPON-specific control UAPI.

So the part I am still trying to understand is whether a minimal 
non-Ethernet net_device, used only as an AF_PACKET endpoint for these 
already-decapsulated OMCI PDUs, would itself be considered the wrong 
abstraction.

If so, the hostapd/nl80211 model may indeed be a better fit, but I think 
it would be useful to understand what property of that model is 
preferable for this particular packet stream.

References:

ITU-T G.984.3
Gigabit-capable passive optical networks (G-PON):
Transmission convergence layer specification
https://www.itu.int/rec/T-REC-G.984.3

ITU-T G.987.3
10-Gigabit-capable passive optical networks (XG-PON):
Transmission convergence (TC) layer specification
https://www.itu.int/rec/T-REC-G.987.3

ITU-T G.9807.1
10-Gigabit-capable symmetric passive optical network (XGS-PON)
https://www.itu.int/rec/T-REC-G.9807.1

ITU-T G.988
ONU management and control interface (OMCI) specification
https://www.itu.int/rec/T-REC-G.988

Thanks,
Ziyou
