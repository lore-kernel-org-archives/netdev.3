Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC949D5AC
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790454073; cv=none; b=TWzSr9Hvn5a13MZyyC7ta9O547VdjR2z2teklsJUIaG5Z5hl4Ike28Zor56300sbc/+/i6ieOkRTQB48MMrOM5Y2f5sTsBzquRQoTiMjoeWiMiX8wzEtev4HBzh6MfrjyZNzfTLjwRPHgeVTSd7qJe31SHoKDzJTqTuNzlHep2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790454073; c=relaxed/simple;
	bh=jANtCOMjbo2tQ4C6RLtj9YK2Urz6WnLYNZcgkUxLeUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzmiY811Dx+hj0PmexWUTFw0mlYa8c6CHIJRmBd6KxQDnV9zt4PvPhaoTOPFArG4vqYAlskebMl9BBq8s6rTY3n8Yphx+K1tyIrD39TIocO8NrDXpsxc5shvtfbbIYFGmfzG3yxxBaAnn1+xg2utFu+0nAMAn/rAJGg6BgRzO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tA9hxeJc; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tA9hxeJc"
Received: by mail-pj2-f40.google.com with SMTP id 98e67ed59e1d1-3a0eeda3e03so179533a91.1
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 13:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790454071; x=1791058871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=dDLYo+urifwolzlinANx7RHSGZ0aon1YRvu/ogO3DQc=;
        b=tA9hxeJcou5P14zop4JjSU62TiNEUoEre2WiXQFvjOF0yLsSxjdpGo9tmp9kwOcUvb
         +edn1ZKtqEQbmh6X8OZeiQk1lI6fyXxycK0KRO3VlsjhMjXJfGRwr5BYH1rWonVtUm9Q
         EHbSBZiJSUIu6DZdSiGxv7zVvY00+YHmNIU4Hb89W3QfvHCZU92RhyHvzLFLriwnbE31
         dLyCkLJNNa13wTRNnTq3/321/c+JS6TS7xmFxLqCREaeiXNuUkDn9x8Wl4BDB8nD49d/
         sTtPOkDA1Bba7OTyqnisy+9Qk1HfxpJKCn4rJrokE2CfhaIMNLlQOc9/rMI6/dG5vZvl
         UG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790454071; x=1791058871;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dDLYo+urifwolzlinANx7RHSGZ0aon1YRvu/ogO3DQc=;
        b=dGLrLXw+l8BBN8c7j8eTvW7kzEE7+vKEdn+x9vSW0oqQWiNRg3B8DhUeMxNe2sTq/X
         XbvuLCeBM4JHHX5QCIL4/BzPq1ir23uoUuHLvLGPhv/EIUIcJ8zdG22BFPKovyYKE+me
         ogcwy9GfWmd9m70NVnHoGXJ+niOuOGTBMa3kAn6Nu14kPwfW8+3hm6aS1WFHo4soTsCu
         cOkqmBtw7kh32U8sPUWelfL1QLg0aorZatRc0GRqw90uWdbq4qtSp9Y6l29GmrnwhvdA
         ZFmSS5d9osZAd+qJaxP4tzdg6cM3MWSrpSRgIc/XYeF7P3OAmKn4ZdP2o4eNo+UqDLuM
         K/YA==
X-Forwarded-Encrypted: i=1; AKwUvBy487CVL8tx8UNvXebwqTtiRcKKV2YTTso328K1KIrfEyZKN8ul8sjMX83Ytm/JrHsi+uXXjZo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiJKeLEJnal/HkGptnbCX7NkJgKkruCg6NqsO6n3Hz5Gi6aCwK
	OYDUbvT/RRz7Z0PZ2G/Mgv+TvjfoHPLCWB+Ymse6jhOetBuJ9MtVHISjC1fpsxN1mv9+Lw==
X-Gm-Gg: AYBFou2M2fNWPhHC7EVuWWPDWZW9qD2BUdJOzJeqG2jUbgOS95xtNtByhD1u5YIam+6
	snd/CfPsk7S0jYWvNtxAlFo6+ky5ElxNn1iDm5otNClZ4RRH0Cw+VLT7lBTu35G1Xh81FPnA39S
	YOOFn577BMT6tzMntBJh0q2GmZJsEJqjfbnwW3NDHcL5gzUKbPZDxmESmOo7WF++5+/F4eU6tZ9
	no5lUb8Zx+3m9HlIyx5XTgnHai0hhwOEmWS1LTk6wA2dQwLxW/QH/eUTugYqrbPzlsfvdP3DELR
	Q/Aqzcnd8CvgBgifgQq0KUdaok0FZ1AoQbuawEoYDBHMqY100fAiTcfug7kWABIGfQbc+iprcG6
	Aa5xC6Goi3t4eKZpwwa/dzp2TWtUyL6Uyn/0mWsBI373TteZ/k9bJMR7xgiZX4MCU3bzdzGu+sm
	NPdcIBK0Ii0pkbHzsXOilaT5qY13JMdwQ4P8rPn2mnkEbC/+kfgpp5qcNbVzZMGCskyLQuLFhf+
	BizeeMknM6FPjsRsFieK+AUqqe2ZFHgTjaFoHynFEiY9PzO8Mb1cHT+z5ccLsTq7XZOEPfYzaOD
	2b3MHx7ko0iOGLIaDyKKfjY=
X-Received: by 2002:a17:90b:2748:b0:3a0:8a9e:1212 with SMTP id 98e67ed59e1d1-3a0985700bdmr6441686a91.7.1790454070971;
        Sat, 26 Sep 2026 13:21:10 -0700 (PDT)
Received: from [10.10.2.99] ([223.105.83.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0cd1c4ec9sm7407602a91.16.2026.09.26.13.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 13:21:09 -0700 (PDT)
Message-ID: <b3348bd6-a248-4df5-8ee4-610cf0a33bee@gmail.com>
Date: Sun, 27 Sep 2026 04:21:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] net: towards a generic PON framework
To: Matheus Sampaio Queiroga <srherobrine20@gmail.com>, netdev@vger.kernel.org
Cc: pbs05 <xuziyougm@gmail.com>,
 Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King <linux@armlinux.org.uk>
References: <20260926174601.1675-1-yhyxwgy@gmail.com>
 <WL64BmXtQq-YjPSMpmv81w@gmail.com>
From: Gaoyang Wei <yhyxwgy@gmail.com>
In-Reply-To: <WL64BmXtQq-YjPSMpmv81w@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Matheus,

Thanks, this is exactly the kind of second implementation I was hoping
to compare against.

 > in my implementation part I have a system controlled by the kernel,
 > without userspace for OMCI, everything being handled and controlled
 > by the kernel

This is particularly interesting because it gives us two working
design points with a very different kernel/userspace split.

The AN7581/AN7583 implementation keeps the G.988 MIB and service graph
in userspace, while your implementation places the OMCI agent, MIB,
ME handling and service graph in net/xpon/omci.

I think this is probably one of the most important questions for this
RFC.

Could you describe what led you to keep the G.988 model in the kernel?

In particular, I would be interested in whether there are operations
which require sufficiently tight coupling with the PLOAM/GEM state
that a userspace OMCI agent becomes impractical, or whether the main
reason is architectural simplicity and having one kernel-controlled
state machine.

I am also wondering whether the transport and the OMCI implementation
could be treated as two separate questions.

For example, could a generic xPON layer provide the OMCC transport and
GEM/T-CONT operations while allowing either:

   1. an in-kernel OMCI implementation, or
   2. a userspace OMCI implementation through a packet interface?

That might let us avoid deciding too early that every driver must use
the same OMCI architecture.

 > I'm creating two new subsystems to control LDDLA (optical) and xPON

The optical_frontend abstraction is also very relevant to Benjamin's
earlier RFC.

I think it would be useful to compare exactly which operations your
optical_frontend API needs against the existing PHY/SFP/hwmon
interfaces.

For example, I would expect:

   - temperature / voltage / bias / optical power -> hwmon
   - calibration storage -> NVMEM where applicable
   - LOS / TX enable / burst control -> frontend <-> PON MAC API

but I am less sure about protocol/wavelength configuration and where
that should live.

 > In total, I have tests on the Airoha en7523, en751221 and en7528

This is especially useful.

Having EN751221/EN7523/EN7528 in addition to AN7581/AN7583 gives us
more than one hardware generation to test the abstraction against.
I would very much like to identify which fields and operations are
actually common between them before defining a generic API.

Your DT example also raises another question.

The hardware relationships such as:

         phys = <&xpon_phy>;
         ethernet = <&gdm2>;
         optical-frontends = <&en7571>;

seem like natural DT topology.

On the other hand, properties such as:

         omci-vendor-id = "TPLG";
         airoha,gpon-serial-from-mac;

look more like ONU identity/provisioning policy than hardware
description to me.

I suspect those may be better supplied through NVMEM or userspace
configuration rather than becoming DT ABI, but this is another point
where upstream feedback would be useful.

Finally, your note that GEM/PVID/VLAN handling is performed by the
PSE/FE/QDMA is useful confirmation that the Ethernet classification
path and the PON bearer objects should probably not be conflated in
the generic model.

Thanks for posting the architecture and the DT examples.  This is
exactly the comparison I hoped this RFC would trigger.

Thanks,
Gaoyang Wei
