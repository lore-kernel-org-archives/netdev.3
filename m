Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322107;
	b=ARsXApVp26qwocOjPdly/QsyVCi3TWVActL2+f0zLG7K3lifFBs6cw+G6Z2o1YY4U3GO
	 mm1PlQUZSOCLaZLzQVoTePS/r8CxbT+SRCFOX06+pKcukKz9TNTAn1kBvb2rUM+espsru
	 GnOhHKASTbpjXD7Vjk3Z3jNqIEEK3AHzwnSYxsrwocanIBzh0WHERkamDKrRTE7kYEo6+
	 tmdj1HfsV0G0hKAYJoZIBzP5KIH4IEr82XTtatYGG/FAUwauSqqxc+qnP3larnDguElb0
	 1hYMwQAEMUwkpYdx3YPWiZxJY26JvmdTUzgQA6fiZuk68i5LICOw9LXfs88yfa3x1ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322107;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
	b=hgLuourHHt2EOkfIJIwQgyJgwxlmOOprW6v1twKyi4X1w10VtAuceGGRQZE9MlyVqNmo
	 fHi9nL48Tc2GO3HTQ8UJIa3IktI49vZTDBwx79flmZLhfuYfwTE2MlK/8l1Ya+U1oU9Hy
	 eKwOJp72wZA62sayLV0WR9GyaP2J/YpSCLxIC7qjM6YZoFK+4pgwLQoLfDH4ISd8/n0rW
	 Si0R5FqfvpLSAqhBULmfjOmqbJUjTFsgDEcAtm+SZXlTbG6E+sHkdnnqQ3d/C0B6HPsFu
	 9OEDBPaJjR5X6RvTFayujlAxrcIwzOgPU9AvYqJ5j72uoTuVLlHts/wOnjPeSKT1bbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0IjpBjx;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mf6rZt+n;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7F760A262D
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 14:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B7F760A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A0IjpBjx;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=Mf6rZt+n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794322106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
	b=A0IjpBjxY0M3zD/E8HAjuGb6t3Xp11W9ws5bW12EQvVUrAYDILjv+6uN1t2x0uGrEXBYsG
	zgWh83HjBPF0oav3BjRO9Digtl/txV4jvYdJ/zm2bImL0Uv9OhVetPe66OrS+CYDgKOgx9
	sfXvUOBhr29EyHNrYSqo/iXNhiTwwpM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-JI2T5xsJOF6PlkDN9__kgg-1; Tue, 10 Nov 2026 09:48:24 -0500
X-MC-Unique: JI2T5xsJOF6PlkDN9__kgg-1
X-Mimecast-MFC-AGG-ID: JI2T5xsJOF6PlkDN9__kgg_1794322103
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-49034831bb3so1931088f8f.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 06:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794322103; x=1794926903; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
        b=Mf6rZt+nD0M+rzWE0lWoLCFKpzfyNhmhY1LwHU1meiHNXvEGhs2nOMiZw1kQcl9G1+
         a6rH4ietR3qT5b57+xAyaAqlteNshFhigxaYbdWCvFq65c/pNmvaIkwGCj/Su/q0BTm/
         JgolJ/fPAZSA7Kz5+e6JrA+7jqNqUuEU0lGjc3wGqPbB5vlv+ayajVb1rJekLo8aNtD2
         t4SMKnUFs5q+jo/gsIkUCg2RtcKMgtYvSChKgnteCPIR/o87uxODFeL4NR+7ruYlHkIs
         +VFfo+x3XOsyEVDuz32CvNxlx2AuOSmam8Mf32O4WuZ1jdCxz5X8wb2cXxBeF2UDDQlM
         LMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794322103; x=1794926903;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HReSs8xkCDmn2RFbwNR87Z/8FnpjP8wlH/AJisucaVI=;
        b=j0JVGVfb7PUvtyVf3LDrX2Kff4LW0lgFapI+atf95NmmdXELzmCtL32LTF4TkwB+yl
         cYpmDRHuae1c83N2EY/BWZb81dhKI+rL3IM1BPUXGpMaxXGZPqHRVUj+iwHJ9s9oSSM6
         gsPV1sc6cEAf57GjI3yI4iKbrRnNWYPPQXKP2M7SsKHUA3D7/DfBeX15Xhrv7NBICOSO
         9X7LtuOvK2+dNTa2Iy0efskmEX3J1K4AO/6u1UtOyoM6LPCiWx/cbyuWHXZSrkmkEDM4
         607OL7AuGU2UL2NSSWu5JC7we0mQP3f86OPZY1f+CB3z5er9wXkPv3S03XhzEOnF0/Pc
         gvpg==
X-Forwarded-Encrypted: i=1; AL+hErGBrTBB9V8hel+Pey5qLRs0NZZ3J3B6AjkjJMHbP1pDzwnC94msn32vSR8KX5pkBuHxIa0Nkx0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zG62IEoZyNieHBfi92CY9lZ58QSbYgSyF6p60Kni7q137yiQ/
	D8G4/nGlHTu3O7NrV7dDhTdysRa+1gZ4eyXp0BSes/FomCdRW9gp6oywjENZxPcKugslFQgltGa
	MxWJ4VWr3sVR0AEtQMr2Gwznx1Fmisrps6iMOrWdeBWn/v7S4pG7FgZYtmA==
X-Gm-Gg: AYBFou1bDRSmvO8RLi7apjJSZjDF8bLfQfuyUz14/lotpWpZcMNKDRM9pL+DZjrTPFm
	acg1NooLcpIJps8hvsGuYVuzpnwqxZaN51UgNa9jPmfnv205ustxUAJw/33N8me9r5Vv/12Drak
	OyPB2/rZVdtH/OE1N/yeBa7boldyIUlYRGXyBn0rdhCjR1+EiNgM027FWFZMvgYYxgdo8TH0eK8
	EhC9ubYas4pBNkOIqHHfd0udUIfC9IKY1guL5NsbECfThJ5pHmHvjzoRoUJSsMkgGBr1eDSQVxD
	kACHyLU0wtrd2AaPuOXHdhXptcgFzecikIe8gV3NtDdQX3MytVGIz/u3H4h0iNUQckWV1CkYDa1
	5JSSDZta5U6hnNX0j8kAOMuC2Dg4FfOD3jTBv0VB85WgDtX9j/khaDD3DbF3Y3gFgjD9sZC8hqu
	mYbXi2/VA7BrMQzdROU9f99Da/ZEBNjIhl2Xw+7cgHEeRs
X-Received: by 2002:a05:6000:3ca:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-49830d81adamr5057441f8f.36.1794322102656;
        Tue, 10 Nov 2026 06:48:22 -0800 (PST)
X-Received: by 2002:a05:6000:3ca:b0:48b:174:eab1 with SMTP id ffacd0b85a97d-49830d81adamr5057392f8f.36.1794322102119;
        Tue, 10 Nov 2026 06:48:22 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm5635389f8f.11.2026.11.10.06.48.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 06:48:21 -0800 (PST)
Message-ID: <984a9f14-d8d3-41d4-a846-6750f710c741@redhat.com>
Date: Tue, 10 Nov 2026 15:48:19 +0100
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
Subject: Re: [PATCH net] igb: do not let a VF set other VMOLR bits through its
 frame size
To: tkusters@aweta.nl, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Duyck <alexander.h.duyck@intel.com>,
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
References: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261104-igb-vf-rlpml-v1-1-729621b60eee@aweta.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 07:34, Tjerk Kusters via B4 Relay wrote:
> From: Tjerk Kusters <tkusters@aweta.nl>
> 
> igb_set_vf_rlpml() gets the maximum frame size from the VF's
> E1000_VF_SET_LPE mailbox message and takes it as a signed int. A value
> with bit 31 set is negative, so it passes the "size >
> MAX_JUMBO_FRAME_SIZE" clamp, and it is then ORed into the VF pool's
> VMOLR without masking. Its upper bits set other bits of that register,
> such as AUPE and ROPE.
> 
> A VF whose port VLAN was set by the PF has AUPE cleared, so that it only
> receives frames tagged with that VLAN. Through this message it can set
> AUPE again and receive untagged frames. It can also set ROPE, so that its
> pool accepts unicast frames that match the Unicast Table Array; while the
> PF fills that table, in promiscuous mode or when it has more unicast
> addresses than receive address registers, that is all unicast traffic.
> igb_set_vf_promisc() does not offer this to VFs.
> 
> Take the size as u32, so that such values are clamped to
> MAX_JUMBO_FRAME_SIZE, which fits in the RLPML field.
> 
> Tested on an I350 with two VFs and kernel 7.3.1. VF 0 got port VLAN 100,
> and a test build of igbvf sent its frame size with bits 31, 26 and 24
> set. Before this patch, AUPE, ROPE and STRCRC were then set in that VF
> pool's VMOLR (0x8f010bce); with it they stay clear, and the size is
> clamped to 9728. The normal igbvf still sets its size (3022 at VF MTU
> 3000) as before.
> 
> This was found by the Sashiko AI review of another igb patch.
> 
> Link: https://lore.kernel.org/all/179370458190.488856.17697539789438631896@kernel.org/
> Fixes: 4ae196dfd61d ("igb: Add support for enabling VFs to PF driver.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
I still assume this one will go via the intel tree first. Please LMK
if I should apply it directly, thanks!

Paolo

