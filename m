Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.208.142.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494416;
	b=ewMTTNiDSfMohoUKFyfJViKiH/9P8QmLLrxF94dYwlkCWK3MafAG/z1GpyDw8qQex5hW
	 hPV9H1KUk2EH4cgWXKTw8arVEUNRRm5rtIX1J7zxL5SWgHmeN7KWrIO73YZLHss+MUhg9
	 Wop4JlhIVEGCH9R1guwex3ToxcxHT0+2gV2Rft18123GCrh3sWuEXKYKItBAP8N01Z9PZ
	 KgFMiHtkWEgES/VMBA8N7DIxdCwVV4ITjLqq4JhuG4SdGbhfvLP3GG3O75gxB4/YNA/6q
	 OSEHQULPRTrCsAhFQ7TT23IA16gg0Irdw85AWVTydEU1X+WCF2TtnO69YI7xRKfNhMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494416;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/aZs0mkZaVGdeH+DoHxPTgzoeR6/jo0wIKqLFSKUOKI=;
	b=JupnEn3oY3+LXiWdU2QHbMHNgH9k+QV/GJNtc009tBI/LFkGwQtmLjAHJG49+Qo1QbWl
	 r/cFFRAKKNxoHF+og9p6yvUwkrrQ4Alysn4HSlEDnutknX/fpSQGwaWgG3KrOG13V6q49
	 Rt1psqiqTItflq5uJYLQu2WILXVjs6Neh4LtG28yUuo6e1ZSe17RZJAJ8uPWMHjDEVIgE
	 hphHKExC3e3TqA17xajzNAkGnfrQ4ybJEGMh8mC3r2z4I4QtwThbExyE9/m4o/pzEoe4i
	 6wf+RrG+StMcyE8i3zsfwU+lzSfj+QwdpnJcnNQRslI10Z5rqqV2xZBKrihU5E0ULaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelriot.com;
	spf=pass smtp.mailfrom=kernelriot.com;
	dkim=pass header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b="5G0imYd/";
	arc=none smtp.remote-ip=74.208.142.49
Received: from mail.kernelriot.com (mail.kernelriot.com [74.208.142.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F45606A323;
	Thu, 12 Nov 2026 14:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 83F45606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelriot.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernelriot.com header.i=@kernelriot.com header.a=rsa-sha256 header.s=kr2026 header.b=5G0imYd/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernelriot.com;
	s=kr2026; t=1794494414;
	bh=b7eTV3O7GSVx0V2kL1SjeFM7wPofa68QgpbjVKUhppM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:From;
	b=5G0imYd/DdWk7swraFWTpI/l384hiUug11UwCdCVZulCogj8JCnTm+tKPDNqFMZPL
	 ghIRtc7OGd3EY8FpntHmjHE2sLABkIKvSkS9f3aIhfooyNth2uVdi1/waQlzwZb9Xy
	 vb8IG0tH0zR6ETMFUrZ5t54xXN8OEAj8gmsy13WgQA603op8jiRbnqBpSD5mmOgB9u
	 lMq/fgDq9ZZmNMAIWIkf0H5zzjahDhWq1dTrGoeDUJPC6ptrK3XNNzt40HjoGWHdag
	 2KSgA3S6HHSoi8DVmCZaG64D3K++Jb5l1jy0EyoBDYkPtxKnmCpbvqYfGEhOSKnWOg
	 O6GHvjgwb0oXg==
Received: by mail.kernelriot.com (Postfix, from userid 995)
	id 7728E81477; Thu, 12 Nov 2026 14:40:14 +0000 (UTC)
From: Magnus Leatti <magnusleatti@kernelriot.com>
To: michal.pecio@gmail.com
Cc: Dane Linssen <linssendane@gmail.com>,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	Mathias Nyman <mathias.nyman@intel.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Hayes Wang <hayeswang@realtek.com>,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>,
	nic_swsd@realtek.com
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in endpoint
Date: Thu, 12 Nov 2026 11:40:09 -0300
Message-ID: <20261112144009.112032-1-magnusleatti@kernelriot.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102135125.121f8de9.michal.pecio@gmail.com>
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com> <CAM6_QD_xAyTFVvYKvCrrZmS+fV5DBBje9V=VdkDMMSpt2ussRg@mail.gmail.com> <20260928120343.49e02c07.michal.pecio@gmail.com> <CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com> <20261002104355.698eaf00.michal.pecio@gmail.com> <CAM6_QD_z7eT+N6HieHyZhPmXqPxKqeSYKX8OK--M+rN2VAsO_Q@mail.gmail.com> <20261013232506.1b4dc340.michal.pecio@gmail.com> <CAM6_QD9NDbVESP5peiNhfU5B_7UmvKVLqNz_85A_GABwDhabiw@mail.gmail.com> <20261102135125.121f8de9.michal.pecio@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 2 Nov 2026 13:51:25 +0100, Michal Pecio wrote:
> This patch works for the simplified case, you could try if it helps
> with your issues too.

Hi Michal,

I tried it on a different chip and a different host controller:

  Device: RTL8153, 0bda:8153, bcdDevice 31.00
  Host:   AMD Renoir/Cezanne xHCI, 1022:1639, 5 Gbps

I applied it to v7.3.3 (offsets only) with your trigger uncommented,
and built a control from the same tree with only the trigger. Each
round was down / ethtool / up, then 10 pings to the gateway through
the adapter:

  trigger only:     0/10 in all 3 rounds, rx_packets flat, still
                    dead 30 s later; RX came back only after a rebind
  trigger + patch:  10/10 in all 3 rounds

Without the patch it's the loop Dane saw, but slower here:
Transfer error + Hard-reset about every 8 ms (~122/s instead of
~275/s). With the patch, round 1:

  +0.0 ms   Transfer error for slot 3 ep 2 on endpoint
  +0.6 ms   Soft-reset ep 2, slot 3
            (3 more Transfer error + Soft-reset, ~8 ms apart)
  +32.5 ms  Transfer error for slot 3 ep 2 on endpoint
  +33.2 ms  waiting for ep 0x81 clear halt
  +33.7 ms  Hard-reset ep 2, slot 3
  +35.8 ms  usb_clear_halt(pipe_in): 0

usb_clear_halt() returned 0 in all 8 recoveries I ran. On this
controller the soft retries are ~8 ms apart, so the hard reset comes
at about +32 ms rather than Dane's +15 ms.

I also put load on it: iperf3 -R for 60 s through the adapter gave
930 Mbit/s on stock 7.2.14 and 937 Mbit/s patched, and 936 Mbit/s
for 60 s right after a recovery, with no transfer errors and
rx_errors at 0. So here, after the clear halt, the chip went back to
filling new URBs cleanly.

This is still the simplified case. The trigger only bites while RX
is idle; with URBs queued, the reset is refused ("EP not empty,
refuse reset"), so I couldn't produce an error mid-transfer.

Thanks for the trigger, it made this quite straightforward to reproduce :)!

Tested-by: Magnus Leatti <magnusleatti@kernelriot.com>

Magnus
