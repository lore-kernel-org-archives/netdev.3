Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538944CA796
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 11:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791543897; cv=none; b=iAgqgooSjFIJrOeDgsF55HUiNNoqVL0uiJWeL1OtZCAAi80aHuSnKS61Uc8bbb9Jnxot8/k/ybjHH3PDqO2PcoiPMO9W9jwCRHL8X3m8AoS0rXoQvWFne614myAFoyq2Yaxrm3jJWBgOf2sdrAbwm8BH+eK2lIV5ZuRdszC99Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791543897; c=relaxed/simple;
	bh=eDmZgvdJBEP/V89rgWffgYB2jV/NsGxr1ioAENM9DCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxb4SR886IpLUxw+EEX0alD1vVT4BkjA4juhciOTwx6GNiOQaUHSSIG+rtEaM+BkkvDNH3igHpItUBbQ4T3bo/RFa3fLU2FY+wQnYr4TyRxRi+e8iV8QLyp+t0mou/Xpf6Fp7fvpyRq+w0CixwjXOpviGJ9HphGcq9Tng+1Y/9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RgeEjXqU; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RgeEjXqU"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3550c917fd3so298864eec.0
        for <netdev@vger.kernel.org>; Fri, 09 Oct 2026 04:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791543882; x=1792148682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPd7mkFszDLuOghTat7AF9sEOa8CyJ0U/uMQy3jtosY=;
        b=RgeEjXqUi5qhMmATEnCZ/DlPmUzwb/bZe3lAA6gAFMxAdnfpUeTKVoXIz5F5JtpmcR
         X1BsysCHTxVIchWPdcWR/1u7N62pxx65/gL64fx0NKMUPaNwxaJ9JVpElOR6O0lVXmo1
         BGgiUzh+anjyOQ52+2brzozESwNAKgDLuUQ6+HcO86KFPTe/3TpHxa2GpL+e8Gd+J8tK
         akKQONHAvvv/TsS+5fYGe49NEIZHZps1yJiYFuKuUKL/DaeKzVLuhyIXc58m5INMJdTN
         fN2XzjYiWgOXDQeHZm5bpXV2ejzCCF9KZ6ZDcHpu02Y3XYqncWTTpPUTyMqb9K5boTHk
         6gBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791543882; x=1792148682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPd7mkFszDLuOghTat7AF9sEOa8CyJ0U/uMQy3jtosY=;
        b=UHAolYjejHyybXWp0sAOiI94bIJXRQEqDlvcYVxovbDoM4HDHmji1JEd8Z7g8mW5+Q
         wYSDzXKXootjTiqak83PZ2/oV4/iSQagS6GitftSjAjk49fkK28gfbUWscD4KXoQd1Hv
         gZ5WxS/5oAb8jv/y5C6J08FbnKA6GxthyFU5Fc8Rd2MOZgLlEPERf4d4WCcWIvSohv0r
         2ea15FX0iRp8mTPMdqfxZB+oxiYLc0rko1IvUlCCXuOUopWPXDCPGhPWj73ENIwjP7oc
         W6tfdtcOx1KuAY+Oc9bSHvqhGgk2F8SwHawUBswwvreas8/Y66fkumDuNX0thdv12ngW
         6XfQ==
X-Forwarded-Encrypted: i=1; AKwUvBztw453cwR52ZUD12rXlBolTV506bFAG3fUWELs8yav8pEI80Gju3aRVbtK5ognogMn/mXyP2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIual/zSdlW9hDn85Vgi6cDpHXNgfMp/2sOhUHnxxH1Bml4eedn
	9t9ccEP4RCtbpLqZDQZPovf5DW82RdjSNCorBuiFrj1bIHcw00cUAZtu
X-Gm-Gg: AYBFou3LzP0t2pRNWcLm5KPpyZIwbhjR8TxxtKCW63uzzzRIZVm4byQrilFY8g/QZvF
	fQjokC2JoLILxDkq2eevcyaqLHAAhC2jTKS4Lk8FJCYO2XQ+9t2zD6LpdqvrEQ7JaRyhaxNWpUd
	IbV26EJYDviCBZbkcFbhGN3TbJSb4gg5uSe9/dfzmHk6Z8+pdBdva+AH5c3310qYVvAs4r2bStB
	WpJBtNMUbwHxZKQGxsXM1cdymDuu999heH9bS3mUoCNJDnwwIpNMN7con6pdGewINm9SOJ7DKSx
	S/ypQoCyZfXxvrNU+YPEgdPoZp9ZYEoFr5mzV4lwnoWoUXuOrs/Rqwo/iplT35Rx/ep6z7X7aR3
	zuwoYAg95YlQxMOBg9VOEBqdO5d0KukXPJbQZl5Pm7NNiNoifDn3hBDcEPdaC1cE437OyAFVb+N
	LVX5A6DIk9NUyy6LErsAKIyM0Nb+GNpF38X4UusrMac1Qwvz2Dr0qBIM8qUsnTYiVc/GCl9eGIt
	u01tKth8jy/UljgTu88fRD+VHOxCw3aK/k=
X-Received: by 2002:a05:7301:4d0b:b0:34c:7e54:65e6 with SMTP id 5a478bee46e88-3537ddf9214mr2077096eec.5.1791543882092;
        Fri, 09 Oct 2026 04:04:42 -0700 (PDT)
Received: from localhost.localdomain ([2804:1530:651:7a30:14ad:c4a2:42e5:ccb3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1ba7esm6350714eec.7.2026.10.09.04.04.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 09 Oct 2026 04:04:41 -0700 (PDT)
From: Andre Ziviani <andrepziviani@gmail.com>
To: John Crispin <john@phrozen.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	Gaoyang Wei <yhyxwgy@gmail.com>,
	Ziyou Xu <xuziyougm@gmail.com>,
	Benjamin Larsson <benjamin.larsson@genexis.eu>
Subject: Re: [RFC net-next 00/12] net: add the PON subsystem
Date: Fri,  9 Oct 2026 08:04:28 -0300
Message-ID: <20261009110428.55471-1-andrepziviani@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261008143249.3439762-1-john@phrozen.org>
References: <20261008143249.3439762-1-john@phrozen.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi John,

On Thu, Oct 08, 2026 at 04:32:37PM +0200, John Crispin wrote:
> The scope is XGS-PON. The mode enum keeps gpon and xg-pon so that the
> uapi order stays clean for later drivers.

A G-PON data point, since the framework thread mentioned Realtek only
as work with proprietary components. odi-oss [1] is open firmware for a
GPON SFP ONU stick on the Realtek RTL9602C. It runs mainline 6.18 with
GPL drivers of our own for the GPON MAC, the PLOAM state machine of
G.984.3, the CPU NIC and the switch, and with a userspace OMCI daemon.
Apart from the stock bootloader, the image has no vendor code or
binaries. It runs in production on two ISPs, and a user has it working
on a third.

I should be upfront: I am not a PON or kernel expert. The drivers were
written with an AI coding assistant, working from the ITU-T
recommendations and from register traces of the stock firmware, and
checked by trial and error on my own sticks against live OLTs. So take
what follows as field data from one G-PON implementation, not as
review from someone who knows the standards well. Corrections are very
welcome.

Our split is already the one this series takes: PLOAM in the MAC driver,
OMCI in userspace over netlink (a private family for now). So our G-PON
driver should be able to sit on net/pon, as a second MAC and a first
G-PON one, at least out of tree (the RTL9602C platform itself is not
upstream). Reading the series with that in mind, four things would get
in the way:

1. The activation edges. pon_state_legal[] is one table for every mode,
   and the comment says a per-mode split can wait for a second MAC. Our
   state machine follows G.984.3 Table 10-1, and five of its edges are
   not in the table:

     O3 -> O2  TO1 expires in Serial_Number
     O5 -> O2  Deactivate_ONU-ID in Operation (O6 -> O2 too)
     O6 -> O4  broadcast POPUP
     O6 -> O7  Disable_Serial_Number in POPUP
     O7 -> O2  Disable_Serial_Number "enable"; G.9807.1 goes to O1

   Each would be published with a warning on every occurrence. A table
   per mode, selected by the device mode, would fix it.

2. GEM port ids. The spec takes 1021 to 65534, the XGEM Port-ID range. A
   G-PON Port-ID is 12 bits. The operator with six GEM ports mentioned
   above assigns 269 to 909, and ours on the other ISP 1434 to 1946.
   The range would need to depend on the mode too.

3. The datapath of an SFP ONU. Service traffic never reaches the CPU on
   this stick. The switch bridges the host SerDes and the PON in
   hardware, and our OMCI daemon programs it from the MIB: GEM flows,
   upstream queues and VLAN treatment from the Extended VLAN Tagging ME.
   Only OMCI goes through the CPU NIC: received frames carry a trap
   reason in the RX descriptor, and we send with per-frame descriptor
   words (port and GEM stream). So OMCI fits the conduit contract well,
   but there is no data netdev to pair and nothing to bridge in Linux.
   Can a driver own the T-CONT, GEM and gem-map objects and offload
   them without a data netdev or GEM netdevs? The VLAN rules we need
   also go beyond tag/vid/pbit/dscp (double-tag rules, TPID, the
   treatment side), but that may belong to switchdev rather than here.

4. Observing OMCI. omci-ntf goes to the one registered socket. Being able
   to watch the exchange without taking over the channel, as Benjamin and
   Ziyou asked in the earlier thread, is what we use most when an OLT
   behaves oddly. A read-only multicast copy of the PDUs in both
   directions would cover it.

One small note for the docs: baseline G-PON OMCI ends with a CRC-32
trailer, not a MIC. On the RTL9602C neither direction is checked or
added by the MAC, so our driver would compute it in software. That fits
the current pdu attribute; the docs could just name the G-PON trailer
alongside the MIC.

If a per-mode state table and Port-ID range are acceptable, I can port
our driver onto the series and report back. I can also share PLOAM
traces from both ISPs.

[1] https://github.com/AndreZiviani/odi-oss

Thanks,
Andre Ziviani
