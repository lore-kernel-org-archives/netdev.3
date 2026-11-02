Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793636303;
	b=zwJ0HOO0K8v/3RiZxhNqAuYMVAm9K1GUB09SnH1psswOEmKihfHs/DgT/CBP0337eb+5
	 PpUtRaQoWKN/CqAf8au0PUgGUJ55jICnN6Bdy6xY6/s5qqpuWR6mSdKk8guifPOy2RdR7
	 0JHVWnqPUJ/LEtuzKowI5T8vOOiFNy34FSjwDN/KEjFsYJPHe0A1fBezT1LJzyl/b09o0
	 SXhkDDVs520U7sTqZwv4cRK05e7rv9mUQ+SoKM19XSKoonVQ/UOH1AjQwtxoZHrIc0htk
	 YGWlSqMDHqgMrMJhpxqaXOzzxhTAkxyscb0Ld1OcCIdmvuU/Exz2stwRoNWSqAU758w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=CcXba6+QSvZDXF/uqMoMEPJwhAO9oMl+Ldeh0etrrCk=;
	b=0W+McsAtnysMBn51uDMdQE9coNJNLX7THGcUdzdkwYHy7KsBgO7PO4rY4vWP46a2cN59
	 LEwOnzGC1v4IKdXXD0vJ1T7vEo1jPfB/76GNqaV8wcXkLkGx7HVpQkfmGjkiUcIQWYRO0
	 u8/bAKxtlVmxBulDlQlJcpaIoUFLrCmgMMqok9rHsICrnwqHmbAGYA6DqU1mDqaXKhTIR
	 PO6vUmIHwnvNF90ZtfAvAZ2wFLirX0z+a7fdFftQ9E8ejF+s/rESOXb/yqghRt52WOoks
	 cMHlqbCa96rRTIJ6yA3VGTU9NgvgchR8Vco1Xaapvo+5CIEEyZ/z3twtrnb+/z7cUCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oiPmSiKG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27786083615
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 16:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B27786083615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oiPmSiKG
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3282db206d3so5197823eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 08:18:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793636302; cv=none;
        d=google.com; s=arc-20260327;
        b=M0X/X4b1Yneg1Gtgkik0ElQ1Q73pB8ufcHFVGRIGcJFQzs9AhvU7ACpLef+x/WXTaY
         of4u3NZtAmkxDexziPcOkB5Zwiy9CVyJz5HxXUm4eO8khMoeBQgbwtRpXI8An2UeZLOQ
         2a3LtECQLbzPeNt1wLMJ5fwVO8FfJu9VzS3bPp2fHV9VujZoBMHSthMmRwZKZifvHcv/
         F9fMGIPrP8Yip4yW9iOHdFfDYaLzgMWoyHxA00UT54PhACgAagZz+ePmgEL3Gd+xKEp7
         k4SMtxbMt6B2G3C4P5GpIzDJIP81C+lQPSEqoXzNib+nuj1Ckm0u7PXW07ld4uWnNVrS
         F7lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CcXba6+QSvZDXF/uqMoMEPJwhAO9oMl+Ldeh0etrrCk=;
        fh=DRVXgpDqa29mwjhlGew22vqJgS+wVwmu/saLMQM3gaI=;
        b=WC1jOsOno52F7lp9Sff5Xm00jQhfMLPUJsjROx28pBcfs78Hj+ql9/CtM2ZR4hGcBh
         C/IxH+sW3Xh6zNn7NO0h0VWVw4yBctDQfkzDpFAWt/CXtR+EQMZPtVRdo6aLtN7WYg9g
         0HhwoGiObH7pCwiUnyK1XapXjnnuSrKapB32IDEya6YUrwXtpQMjkXcozUMSVKnufoC0
         FXwKIzvbXxIF9AXYcJqRwQH3u+B5pCu91AnqdKMRyvr0/vnpVIb8uA/8EJw22+InF8ga
         f5yadvXcNlRrswxA6FwRXOKZ/6evfpE9KGz8By2eU+rKocFm0AKKv1uQkl6oe/YN6vFj
         T+UQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793636302; x=1794241102; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CcXba6+QSvZDXF/uqMoMEPJwhAO9oMl+Ldeh0etrrCk=;
        b=oiPmSiKGc/9iR+p8CGhW031Q6pD44el9sD5FeY84Wj5De2OZRNH5+yEF+BjF3trLUy
         3n90pJtd+8i7QflHvhbZR3TL6YRdBcLpzS7TMgnd5QPSbPzP/mTxqUQ7W1OfX3ZjS85R
         lyG3G1R1FzRJEKMKnLZ4c4X3dOZ15PcZou5xmxcALNaTwT8bgY6bKOvERVde6VIs3kMf
         R1LORE/nSdoKQYtObvSjP6EdrUDwcg9ERikwNXCXGLkUehj9fCQozAxqk3lammBcRMYM
         7Sym/p7vzJIBrGAM02OZbuh4ZZ/9Msf1jyrMvwqsqDay1oByONDJKXNj/QPQPC0aTh/U
         QOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793636302; x=1794241102;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CcXba6+QSvZDXF/uqMoMEPJwhAO9oMl+Ldeh0etrrCk=;
        b=yKYrWYSaJ+x+sCYlhWc5F/F4PKpT1cd1B8v40qy09iBoDpJxospQYEH6a2ABoIr0s+
         uCws8PiRfSZpqHvqE+AiC1CEEigcRJrEIW3PwLmFMTGmu5snH03HIIAxvIRZXB2iG3qi
         RT2xbRM88VkNyihDoi7/tUNUJ9sPkWt/Hnn14E+2CgT2tDbjXypfp2dPwuF4H6jbWv/K
         wC7r26omR1d1pjy7sMkaBwQ8tMRrepqei0c9PdpnQADMcm2AsUd/G4w6iN2Eqfp22Eb9
         QmaawVLHSVVQ3xjMYUoybr7sIdvFYvmUs4eHGWremMUqsFSn6sVlA9+JyeZ4Z0JTDwVu
         fFZQ==
X-Forwarded-Encrypted: i=1; AKwUvBxoYIMGgkIjlqJzJhAqiCv8/RICsurWN76COLJ6Fj34qKqU3gVBxy5bZplKLMeFT/CmY6UjXWU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bdyxwkGxszS/OCxCkSfW7rM11J41BiF51cDEEnz8cHwYnAxCB
	AMCv3fKiGvrqb9wur6IWhJ8NMaRQ5Ios30c0jThWJuWhkMVfXW7wUvM6H273tJQ9iPmKWjcUfkn
	peVIhBl9Y8d2UZBjXAdaKbZJs6CFM8Q==
X-Gm-Gg: AYBFou0FokRIkqljICVMkS8Rvog7Uqom8xjFkSXVVIv5ey231EZXgeUgE+f/XV4OOzi
	xK9PDkSv42uqR6eBuzYYE8UX3fpmpL+8CbK43dAlO1RvaCAGNq0dT+bmc9YwdtoaQiR9G8dM8AA
	Ul7rb630rYDClov3ui2rQsZb5NxDpkBVU2KYDHwbEUC9IrHhOecPV6m9cNTBba5Q8TxQzp/CY/G
	em7vXqMlpYyL3hrfMyOIz1Ptx/gewo7dzdbwaq4/Q9HC1xY2PtfiTqOMjTMv6koO3sHBaTcBdOC
	HPO+VwGlpjjXqFH1Q6EIJ4RqwV4z7S/LMdWZy56Dpr5Lo/1McOcIkpBDm7AfSnR+4kePxCBdBmq
	rC0AvQc8+B20bukMrCkFidE5XfoLWKisUlmpYA7Bi5GSS7kEPl8HdsQ63PDJXaaHlmyNaGBp/yo
	sXcBVQ68Q9zqtfwqf1kDo=
X-Received: by 2002:a05:693c:864d:10b0:369:9062:c392 with SMTP id
 5a478bee46e88-36a424261c5mr18440928eec.37.1793636301684; Mon, 02 Nov 2026
 08:18:21 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>
 <CAM6_QD_xAyTFVvYKvCrrZmS+fV5DBBje9V=VdkDMMSpt2ussRg@mail.gmail.com>
 <20260928120343.49e02c07.michal.pecio@gmail.com> <CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com>
 <20261002104355.698eaf00.michal.pecio@gmail.com> <CAM6_QD_z7eT+N6HieHyZhPmXqPxKqeSYKX8OK--M+rN2VAsO_Q@mail.gmail.com>
 <20261013232506.1b4dc340.michal.pecio@gmail.com> <CAM6_QD9NDbVESP5peiNhfU5B_7UmvKVLqNz_85A_GABwDhabiw@mail.gmail.com>
 <20261102135125.121f8de9.michal.pecio@gmail.com>
In-Reply-To: <20261102135125.121f8de9.michal.pecio@gmail.com>
From: Dane Linssen <linssendane@gmail.com>
Date: Mon, 2 Nov 2026 17:18:10 +0100
X-Gm-Features: AclHuK--jr7yX0N51mMeigjqHQa3DhOtTsDC_f0Xm_ujdo1a4DNU9CY359A64s0
Message-ID: <CAM6_QD_ceOeoiv8HC5aH5nMHoisnAXGxMz6tRAbgmp3RD_4cdA@mail.gmail.com>
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in endpoint
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	Mathias Nyman <mathias.nyman@intel.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Hayes Wang <hayeswang@realtek.com>, Chih Kai Hsu <hsu.chih.kai@realtek.com>, nic_swsd@realtek.com
Content-Type: text/plain; charset="UTF-8"

Hi Michal,

Your patch works here for the simplified case. I applied it to
openSUSE's 7.3.0 (offsets only) and tested on a second host with the
same RTL8156B (bcdDevice 31.04) and an Intel xHCI (8086:02ed), 5 Gbps.

Without the fix (stock xhci, r8152 with only your trigger), down /
ethtool / up gave exactly the stall I see on the other host: four
soft resets about 3.5 ms apart, the hard reset at +14 ms, then
Transfer error + Hard-reset at ~270/s, and virt_state 0x40. So the
onset of my real stalls can't be told apart from a desync that starts
at the first error.

With the patch, three rounds of down / ethtool / up all recovered.
Round 1:

  15:56:52.892  Transfer error for slot 1 ep 2 on endpoint
                (3 more Transfer error + Soft-reset, ~3.5 ms apart)
  15:56:52.907  Transfer error for slot 1 ep 2 on endpoint
  15:56:52.907  waiting for ep 0x81 clear halt
  15:56:52.908  Hard-reset ep 2, slot 1
  15:56:52.908  usb_clear_halt(pipe_in): 0

No errors after that, and RX worked: the gateway answered pings and
rx_packets kept rising. usb_clear_halt() returned 0 every time.

The host that stalls on its own hasn't stalled since 10-28. Three
things changed around then: the adapter moved to another USB port,
the kernel went from 7.2.11 to 7.3.0 the day before, and the host now
carries much less traffic. However, a 74 GB copy at ~15 MB/s over the
new port on 10-28 didn't stall it.

Testing your patch on that host needs signed modules, and I can't get
to it for a while.

Thanks,
Dane
