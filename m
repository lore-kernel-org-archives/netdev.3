Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85FAF52189A
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926715; cv=none; b=WODX4sCPTX+MIEI5rGp4JmP7yX3+Cz72jOYYp6Qw5dsR/5Sv+rZRRyBydW5nulVOx7rZdFrfEPXR4cyLhxfTygdR2Ji1wJ5ELVrIQ7ijW61g5pdvTdXIruhPAwTtH5w04mr1Zm0SY4TAKLEcvHL0KbiaR34vwG4WPNBAKgCRzf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926715; c=relaxed/simple;
	bh=aH8eFs4okB74zTwi9QU6AWy5tkbVovGm8jg+grpS26o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eoQfEsqQ2P3WBiJgUez05CsLxB6zw0bNFOgKlIuWkY7g5Tt3kSP3iM9QXOt3Ba2vsamYi+Cu+JULOUSRsdooSnhEvaFCOORdNGEVk+oUiA+VPYe8MIwjaKiPP1dgaGBlKAlNAuNUXJB5YjBjiPnHnyvt/lJDOfs/yilSuILXI0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCMX+K2G; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCMX+K2G"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a16aaf2067so4112315e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 14:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791926710; x=1792531510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9bFo6t7SK13AR5cV2462yCbw9SAQMOU3jnzNDJAtDAE=;
        b=gCMX+K2Gi6pQ83GcMDnrnfouu+qRX9WSo8d6j75/qJ/WnigR4WoXdN7shkCMT6ImFG
         DujGwT0jBS4ExxR5/6ML7hARxJxAY/yUxFT30Rkg0DZScH9rPOI/miNB7iaoRZYubKGN
         DOsU4LtqplRgKNg1sXS3Uax0/uzxbG16DAodYUFE/VvMdohWyK2pVzSL8xosFVska1d/
         AFadBmxneLg0Pr9hHM7/FJzDUSr7pAxPOM9m9+P0pj6/mVVYG4nYHUA+yoq571QwbBID
         Q3tXHJ/5ell2cu7KtXH7UYLgNmsi8XIRL3JtiCbkPWwf6FOowYvHYUcpmhwBvctq8Thk
         MnZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791926710; x=1792531510;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9bFo6t7SK13AR5cV2462yCbw9SAQMOU3jnzNDJAtDAE=;
        b=I3p7KZO76erDEV7NNRjrM7e0vsInjJYgCf9KDSbOaxBQqNrjHOJ+Wq5dvKDtvJITqn
         pgiAETOJQ6GLlsQtQTq3VWBG8+1fF57QV4fztb6e/VYzYF7RIf+Pah51Jyt9AD+KtovC
         Knp8cJvsPfHoIrqCsMSsUvgjhcif8HmDcuNWl5px1qga7Fwf9R4VM/ojEz5VKPVxp6lQ
         QnCXS9e2deEG0MgyJ8uLdpySrPgfd7RQ4X+SHyVgJgYxsPtu/EF5VR2AyrQVGzSejj0y
         YLnJ+SYHDIG9Lga7ml/r95boKrxMtOeOnE9RG1x1cHU+224KjwTvPMORkpuTN+kFLTHW
         u23g==
X-Forwarded-Encrypted: i=1; AKwUvBxjCjqcGYLfuzLA7CmSDLeC0n2lvSO+pFlidpRKTovobmkg09IIZUsVbbqw0yZXD315RfdwNNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGH3rigSeZocYtQ0il05p03aSBp9GVE3LE4pfV/CCk1tFsvIoT
	S5fTqzmuPzIuYyI1IDX/YQ9nXOD7s/jv3l6aVCZSuIIxWdflMFx09slL
X-Gm-Gg: AYBFou2OHW2Xo3MQQoOw8lxBSDD623XIWJpUWkHcN1wTTI+CaiqNlHDVYPlbxERMtKX
	L58EU7xUq1G6DFFxDVfavRjebnKCQt3MldotVsrjCxK7biiQUfz337iqLZfeXmj6ptt+MkBeYLo
	QMVyqZ8kFy04gFwM/3f/yhp1AMeRGY7Qspd6wfTHovxtZ/jEXK1Cj2egJlqK4gp5dejwvH0o4AL
	8yZJlAymwckoF5n4cU9Q2a8g5UL9HyX/VtKMBz4cmt/rF1qHlAF3boP+gKdWibpcolc34WteYKH
	mDgDkxls3XFXnYzy6YStxho4JeTjtQVcDJU7QGE1w+kU1qA/tnixLTfBqmQSCgT/keZFz9C3jFG
	RMKQO76lX6im+qDCJ1WqlbHnMWEq/ckST33D17lqI46DlZ3Z+DxWsJjFHWA1k4Z9RwzQ1bZ4oR9
	HUUR30YsWC+orlovqI5QenJGdZitPRpjFh3F7fSERv5JrSmOMM+nGJSmCpPD2tkuUldWGD5cRMg
	IEWneiArDLt8zkkt9Zk
X-Received: by 2002:a05:600c:4e47:b0:4a1:813f:2a65 with SMTP id 5b1f17b1804b1-4a18e4b1a6fmr241305015e9.15.1791926710418;
        Tue, 13 Oct 2026 14:25:10 -0700 (PDT)
Received: from foxbook (bez186.neoplus.adsl.tpnet.pl. [83.28.37.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a195002123sm409441305e9.1.2026.10.13.14.25.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 13 Oct 2026 14:25:10 -0700 (PDT)
Date: Tue, 13 Oct 2026 23:25:06 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Dane Linssen <linssendane@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, Mathias Nyman
 <mathias.nyman@intel.com>, Alan Stern <stern@rowland.harvard.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, Hayes Wang
 <hayeswang@realtek.com>, Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: r8152: RX stops until rebind after -EPROTO on the bulk-in
 endpoint
Message-ID: <20261013232506.1b4dc340.michal.pecio@gmail.com>
In-Reply-To: <CAM6_QD_z7eT+N6HieHyZhPmXqPxKqeSYKX8OK--M+rN2VAsO_Q@mail.gmail.com>
References: <CAM6_QD_PoTdwdM7DvzzgHRs-G5EvQu-c5oNGve=GuKV4wFYAvQ@mail.gmail.com>
	<CAM6_QD_xAyTFVvYKvCrrZmS+fV5DBBje9V=VdkDMMSpt2ussRg@mail.gmail.com>
	<20260928120343.49e02c07.michal.pecio@gmail.com>
	<CAM6_QD-CbYSsmic5LhpMi-aMXuC_VaniELBzaBeWO8SWm4UONA@mail.gmail.com>
	<20261002104355.698eaf00.michal.pecio@gmail.com>
	<CAM6_QD_z7eT+N6HieHyZhPmXqPxKqeSYKX8OK--M+rN2VAsO_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

[Adding Realtek people who contributed to r8152 before]

On Fri, 9 Oct 2026 14:23:57 +0200, Dane Linssen wrote:
> > You could try it. We may consider increasing retries in mainline if
> > this turns out to solve real world problems. Though so far, in the
> > only reported case of 3 retries not working, 10 retries over a span
> > of 100ms weren't helping either...  
> 
> Thanks, I'd like to try it. It needs some setup here first (signed
> modules), so it may take a while before I can report back.

Looking at the log below I'm not sure if it will help. 15 ms is quite
a long time and my gut feeling is that a temporary link disruption
would be unlikely to last so long and not affect TX, unless TX is idle
through all that time. Do you still have those usbmon logs, were other
endpoints active in the 15 ms preceding the first -71 status?

Absence of errors at other times suggests that this is not a case of
barely functional cable causing high rate of USB packet loss.

The other possibility is that a HW bug gets the endpoint in some bogus
state and only resetting the endpoint or whole device can fix it. Maybe
resetting the RX endpoint would suffice, and the driver schedules some
work on -EPROTO where usb_clear_halt() could be inserted.

Question remains, how to get the chip to abort the botched transfer
and start a new transfer into a new URB cleanly? Is it enough to keep
submitting URBs and eventually things will resynchronize? The driver
seems to believe so, but does this really work? It will need to.

> > Any results yet?  
> 
> Yes: three more stalls on the same host in 11 days (09-30, 10-04,
> 10-06), all with virt_state 0x40, each recovered by the watchdog's
> rebind in about 30 s. Dynamic debug was on for the last two. Both
> start with a single burst, and in the 11 days there wasn't one
> "Transfer error" on ep 2 outside the stalls. 10-04:
> 
>   22:36:09.251 Transfer error for slot 4 ep 2 on endpoint
>   22:36:09.252 Soft-reset ep 2, slot 4
>   22:36:09.255 Transfer error for slot 4 ep 2 on endpoint
>   22:36:09.255 Soft-reset ep 2, slot 4
>   22:36:09.258 Transfer error for slot 4 ep 2 on endpoint
>   22:36:09.259 Soft-reset ep 2, slot 4
>   22:36:09.262 Transfer error for slot 4 ep 2 on endpoint
>   22:36:09.262 Soft-reset ep 2, slot 4
>   22:36:09.265 Transfer error for slot 4 ep 2 on endpoint
>   22:36:09.266 Hard-reset ep 2, slot 4
> 
> From there it's Transfer error + Hard-reset pairs at about 275/s
> until the rebind 40 s later. 10-06 is the same: four soft retries
> about 3.5 ms apart, the hard reset at +15 ms, then the same loop.
> So here all the retries are spent within 15 ms.

After "hard reset" it's a 97% chance of endpoint sequence state being
out of sync. On USB3, resubmitting without usb_clear_halt() is futile.

Notice how baf33d7a7564 ("r8152: avoid to resubmit rx immediately")
only talks about disconnection and not recovering from these errors.
I suspect no one has seen such recovery, at least on USB3. Easily
recoverable errors don't reach drivers due to retries in HW and SW.

> usbmon, 2 s from each of the three stalls: every bulk-in (0x81)
> completion is -71 (571, 553 and 551 of them), none succeed, and
> bulk-out and the interrupt endpoint complete normally.
> 
> The other host with the same adapter logged no transfer errors at
> all in the same 11 days.
> 
> Dane
