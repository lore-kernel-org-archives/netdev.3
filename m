Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872296;
	b=mHOgnyPK1t9ijw635hN4JQU2+pbRP35TuO9YZGeMOZEHCKjgQ0T4mvy06AwqjPnHApof
	 Y1TzB61yVvGJWv27IW4+qe/DXb/8GOFFItaojiUTMpZ6o2AYlCt+C1Amwg8M4IwVbKdXE
	 Zj7T69PFVqH82Bq3RgZXMl8Nc3CLh7OuAt0DvSBrt4Adeqf8nVUEO8wshV9K+k4kjgLpp
	 tHKdCKyhpKlnxGdOT828ozyEcvp5mbqam7ba9Yb6fgXsRJTnCQyDD6QIFVNlRD2ifAb2A
	 Mfw0wDpBB/h/uMwHLgN58eoMpxFlxMC7AO4DjAQ3MdKdbFQthsF3HqJwbf8liz5Sv2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872296;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=ntbAVzKKszvhnnecyjPK9p4OIP/hmO9ZcKNX919vInk=;
	b=lw4mctycSzkUQPU8I6zmikvYdNdwWg+PRuQGZZuaJcirRZgEH6FRF1wFxTuCiOv9Spyx
	 J1VtlcgnNAR9eJD/xuObzAaLe6YNk9ueldWpWzcNKXFcijgRCBIAfQgNsgVIIlkbWTQxc
	 lqgYCdyy2zKXDy/xLrueiLII8XkfpoBHql5VEnftb0pn/wDPmqlgjcBLeRL6Gr9UX4zVr
	 roGZcQscJYVk57XsybpOjZHiTBKDggy1Hso+Kn7FvR81MPMOQCMx3HAP3Rl8kyLmIv3aZ
	 du4cYq0IZ77GzMsTNkz7ogt5QPMflmXsWe/mDzlVrdwnOoPl0qmHSiZ9+FqhhnrtAXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="hkJd/cGT";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KBxm5ORs;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890B3606A330
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 09:51:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 890B3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hkJd/cGT;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=KBxm5ORs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793872294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntbAVzKKszvhnnecyjPK9p4OIP/hmO9ZcKNX919vInk=;
	b=hkJd/cGTXQf8gONRmfwGMkSqjAveIZ2oxKo788DmB8g8svaAgniC90naYOBMKiCvn1B6Mx
	raORHnBkVLr43IxM4qE0lmHX2twwUd1EAqEkjUXAnyOSMmN26WdNdZkl9g67PDisED2uJQ
	2HAvQLOv/S2WIdx9mE4acaLPG2JbjSE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-Ku5ILT3wPXa1kmBK5j1g4A-1; Thu, 05 Nov 2026 04:51:33 -0500
X-MC-Unique: Ku5ILT3wPXa1kmBK5j1g4A-1
X-Mimecast-MFC-AGG-ID: Ku5ILT3wPXa1kmBK5j1g4A_1793872292
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e29c25101so894059f8f.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 01:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1793872292; x=1794477092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ntbAVzKKszvhnnecyjPK9p4OIP/hmO9ZcKNX919vInk=;
        b=KBxm5ORsYSzevNZymCpImPIMAziH3zAdtOVBWYadIPwBFRJgSwQwekaClE4pxP0Mmr
         ZivCvjByDkgCdV/L6wa97qihOlOBJkbMqtwQjFplZTRy3dYG/pUbATZCoxxL8kyL0AcI
         SMYOGTI776enpJv6wMnbpKM/jChav7qhJF3gTxrNXxHz1QsirejANXR/Q3i/DoEBHn3M
         PnPLIeKjCj7wtAnELTw1LdJ4uqhdLLDG2ktV6BttQFmuayzXWcNZZoDrEGizbksUtsHn
         sWSJQOC2BWT1sY6henWes33721uWMTNiTsRkZ2uQGxRDkZsiSeSv2rEEpmHr3Y269WYR
         hNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793872292; x=1794477092;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ntbAVzKKszvhnnecyjPK9p4OIP/hmO9ZcKNX919vInk=;
        b=xQNI+wDUPOIQp10VmsARJGekv4a+xrOEYoWFVFXA+H8X+h0mhpTXTKgIecU8S+pqA8
         iVpDjm9dBKoaMCriy3g5W4fY+N4/UNn8J4wc5lbxKD9Dg0OmDqwE4YfI/2W/iiv3u2n4
         A0WvxDeAVDtMnRgbdPPVp2Dkscfnq36+jMBfwb/ewPgoGbOrDvjzFh+lbKwm73NTLM2f
         OKVgbOv7Ucqk+lcU0tJP8fzGjM2cWNZK4wtsPMKp6Ph41tVJCTJ52c88BWLFVr+jtOz7
         3vQr6uu+a9wIZHj8BjQETlk4MkE8I7ekhxKfo3pIxJznYiT33xs/cD0MdUeC/ENHJ2uQ
         PJmQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTZoS87ZrSp3lB471VAa/6hgTdtMaE2fgPosD2OKf6MPAKxgaQijOPzMobuDbL8gC7oxBVrCk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SFSZtEyrm9Mws+gWdhC3i/ySy3lQ4bK9IHi4j6ceD0GeyfZWv
	bflYwZhVj0EsvBRh+0nHnj23IfpUFTt2j7iUtEw9UPF+LFTVKlZsarEKmuyNJ0VyIVsiw1rLtHd
	BU12SiwgkpXJ6nkmR3QerY8JW5/IUHIU5SOwSW7lmshyc8kISTK/6ZQBAvw==
X-Gm-Gg: AYBFou30/3H41aHnRSdVMDJ8eWNgR0va6Kji6YA2mV0mlSlimJS6OIinVfQQaj1IbDH
	JkHclfDGR/Y1JC0IJVgCOeJIC3p12DJIdZpt3+j1yCmd4fZm+dZ8jsGVIb9Vv2jV7S0CFA8mtz7
	Szz2wcc+BgHm1FjBEitlJFouJnVIJEZtF1dtnTHDcaiqXXyaOz3DXgvnFj/SeheqlqaH1E+3cAq
	uIMSFv7W3v7LUic63f6dJKBE7fPV95YgnNkf1BKXgYZWknoFzQKvex/CpFxBdhUnSwh4YNya9Vo
	eLy2yDQ73r6YSAaf1bY5StCBiG0+w1Y47VA+vEHarFjM1wzBg1Qe+ti0o5ocjzD+ZgmXHNI6aUk
	K/gXDwSHqWp5z3/p1jcJP9hEELmrGtMti29R19+1vG16RdcXkLQXHwjGcUfuruNVi/4/Ghh95Vq
	wRMvbJvjeLYwEFW/BaKaFc9x08ukVm/OoazifEjmmtdnA=
X-Received: by 2002:a05:6000:430d:b0:490:da85:7aee with SMTP id ffacd0b85a97d-490da857cbemr5409715f8f.24.1793872292018;
        Thu, 05 Nov 2026 01:51:32 -0800 (PST)
X-Received: by 2002:a05:6000:430d:b0:490:da85:7aee with SMTP id ffacd0b85a97d-490da857cbemr5409669f8f.24.1793872291556;
        Thu, 05 Nov 2026 01:51:31 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fea1811c4sm8980486f8f.3.2026.11.05.01.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 01:51:31 -0800 (PST)
Message-ID: <6810d4c3-a3b9-4da5-97fe-27cfd92563c1@redhat.com>
Date: Thu, 5 Nov 2026 10:51:30 +0100
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/5] net: sparx5: add tc matchall port policer
 offload
To: Daniel Machon <daniel.machon@microchip.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com,
 robert.marko@sartura.hr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261102-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v2-0-3bd47ec1b227@microchip.com>
 <679b8dcf-0aac-4674-a006-5af0156a82ae@redhat.com>
 <20261105093905.ln6tdot26wyej7pi@DEN-DL-M70577>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261105093905.ln6tdot26wyej7pi@DEN-DL-M70577>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 10:39, Daniel Machon wrote:
>>> This series adds offload of tc matchall filters with a police action to
>>> the ingress port policers of Sparx5 and lan969x, which are both served
>>> by the sparx5 driver.
>>>
>>> In hardware, each ingress port has four single-rate leaky bucket
>>> policers. A policer drops the frames that exceed its rate and burst.
>>> The four policers of a port share the pass and drop statistics counters
>>> of the port.
>>>
>>> The driver uses one policer per port, because with more than one, the
>>> statistics reported to tc could not be attributed to the right policer.
>>> This matches lan966x and ocelot. The policer meters each frame without
>>> preamble and inter-frame gap, so the configured rate is a data rate, as
>>> tc police expects and as on lan966x and ocelot.
>>>
>>> Since the policer meters all ingress frames on the port, only filters on
>>> chain 0 with protocol all are offloaded, and filters on shared blocks
>>> are rejected. A police action that is already offloaded as a port
>>> policer on another port is rejected too, since in software it is a
>>> single bucket for all of its users. Only drop is supported as the exceed
>>> action, and the police overhead parameter is not supported.
>>>
>>> Patch #1 drops a redundant prefix from the existing POL_UPD_INT_CFG
>>> register macros.
>>>
>>> Patch #2 adds the registers used by the port policer.
>>>
>>> Patch #3 tracks whether the ingress block of a port is shared, and adds
>>> the per-port policer state.
>>>
>>> Patch #4 adds the hardware programming of the port policer.
>>>
>>> Patch #5 adds the tc matchall offload.
>>>
>>> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
>> I understand the following will be very frustrating, but for unknown
>> reason AI review did not kick on this series.
> 
> Yes, I noticed that. I thought you maybe had some magic button you could push,
> in order to trigger the review manually.

Unfortunately, I personally don't have it. AI review is sponsored by meta,
only Jakub has direct access to that piece of the infra, and he is AFK for a bit.

>> The changes looks sane to me, and addressing points raised on v1, but
>> I think nowadays we need an explicit AI feedback.
> 
> Ack. I think the missing sashiko-nipa check is not isolated to this patchset
> alone. Just FYI.
Indeed I hit more patches/series without AI review. In some cases I can run
the model locally (for single patch, due to many constraints).

Thanks,

Paolo

