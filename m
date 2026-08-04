Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A073B2FD0
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864009; cv=none; b=D7WwPBfFmuZRR33QIFLGrLQdCTqrrfvNzpzty/cd51v6r7kNka3vDVDOBWiSoSM2EKrBNgSFySlpqsFWnKpwsFEzMKLo2RvPy/XF0IarwcQWyKDCJ49V/uw4cIPLHp923rYlor0CeGMlFwY5iEDXPBilFpVVTtExFv0diBPGnaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864009; c=relaxed/simple;
	bh=tn37vxDktpDeGNGM/rBHg3ypjb94/j/pKijNf4Af2V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auqT5jw1UAiL3PyCAd91w3jHBBH4kfHB4jq8uyYMcTEYYOVmLRJWY9MR8CmkljCrB9BX7gjS0iQLN0W0LcOAXoIujw5NjLaYqkqxyMASznbCS85V7coIJGZonglMlA4AsURli7ru+LVz+gNoKKYHLsP6xyjHKEKCpWkUhhEJ13E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G0bQfcky; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G0bQfcky"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-930fad20240so6776585a.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 10:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785864001; x=1786468801; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OCTjJNAS4rOdu/mpclXfbvVSReH6ouoLdPqO+Ho98Y=;
        b=G0bQfcky/kqtsFltIMez8SJRfkbHcNAMtu6Xl7ZmXizeEYASwSEnpTFISmu3mo65y1
         Y1MIxjSRKkamTrT9V4TNzKz3XoHsQOIcMxxAdSoYUKbCiUIROtCT0QEeDkQ3Xc04CKPG
         ShZjbmKmFFF3WOfIqt/18PpjsHqHQ/sfvmglC0YJbj6zUNkDlP2/UL8QHhe5CXavsvQC
         eOOUlH7R91V+av0Yn3KkCEhhDa8fSfs72WNsBsh5KeFURdLuP10dYQKxo7UWFc9+NVY4
         GqbQVXx0pjvmDpFa80nxmG9rrIQ0iuRpU+Hg//TWP0rtDWYUnMa42ax12kNoFW+4PkUQ
         oUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785864001; x=1786468801;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OCTjJNAS4rOdu/mpclXfbvVSReH6ouoLdPqO+Ho98Y=;
        b=nWytUqGp3M6UssnEfud4cV5AeAEbhkPWWh6HQecaeNrE5Gb20lVgvwGUJuXClLHdXC
         cQHjCkwDgQ37YOGHUmxoqe7YnoJwlDM3eGFSUDOZifXcdZCTf1M77RYy2LqxUsopS2b0
         /cjvbhzXRUtTTqI6PHIWjreemmsjT0RvOcLZtwzu9JcVlIUOaacyKRyHiaB8QaNU+HK3
         RhM5o3ad+x65Q/7MwNMg2j0pJM2HItRnnbCwlco9LQ6e/gsKi8/v362m//GN1AKcJ4M5
         av2xr9We508WTd5qsV0xAapNXI8h7c5MeROTuqzGPgVYOZ0v+gd84BOLOQMcrX1BMp9g
         vlWQ==
X-Forwarded-Encrypted: i=1; AHgh+RroHWs4gQw9GDZ9Uetf0neJClbC8/WMEon0piBdEek7OKWNnfwXaGPtbjJ0NEfqe39Ke9qws/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwD/GQfPpJCvhziYj5HKFGhZomYp+totJaOHfKHwjMfNqljtR6
	r7aiKGAla8+z9Fcu+0kRiUHAFLplov5CorzokRsbOjirT5TVOQYQl/ka
X-Gm-Gg: AR+sD11u2D1qBT3oIpwp/5alkUyiKml0AjdXD+YPO2qubCqbXjEm63+lU/aHjkjlYQV
	DOSG4W75NDuZbQf3QFrhOAiad2pb6OwrHzJZQrsPaaUfL4UnyqQUYcTrZFsVkNQV26sIdfM6MmN
	KVyjSG8moVZ3GfAtt0AMknbsIw4HDdakAO+pqNZTLbiZNdQTBx1An0WlD4OyuNtMOWoELJBK88V
	sBYWSdGm6woaRQJV0qscmG+u3FTao1BpBfptXwMXVqepWNF+S/d4hiDZfPK0h5nqR2WQTatn4gi
	8UHjHln7w4WvNFBeqSbVtaBCFPMs44F8fk/aiVwi9RhO7Q60XTbpC1TybHHNSohOZcQaMSPAcSR
	sZQb4j4E8TpKPksEU9d44hi5yzHa4qaO+N5nvOjqI5uS94qggUyta/GFPHAsUD5zQ4AeC+TcFx/
	jSOAg/dski1SgBp49ZdkWW6X2bJkn0T2siz2tccZZJfiv7KJY0W1whgnqedxlVQRnq7LQ/LhGMV
	RiFwlIF3/+x+2SlHtlG4+0H9zCaiQul4H5CfWno+sErvmwvrm9+nQ==
X-Received: by 2002:a05:620a:8bc7:b0:930:a631:68bf with SMTP id af79cd13be357-934a0955e3amr2166079185a.22.1785864000974;
        Tue, 04 Aug 2026 10:20:00 -0700 (PDT)
Received: from ?IPV6:2600:4040:9399:4000:e553:72e5:7d37:c7ef? ([2600:4040:9399:4000:e553:72e5:7d37:c7ef])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93641702c6asm126843985a.3.2026.08.04.10.19.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 10:20:00 -0700 (PDT)
Message-ID: <3a936f25-95b1-4b85-9d8d-d5ef9949b7d6@gmail.com>
Date: Tue, 4 Aug 2026 13:19:59 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 09/13] net/mlx5e: psp: Add an rx_decap
 steering table
To: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Alexei Lazar <alazar@nvidia.com>, Boris Pismenny <borisp@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Chris Mi <cmi@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Doruk Tan Ozturk <doruk@0sec.ai>,
 Dragos Tatulea <dtatulea@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 Jacob Keller <Jacob.e.keller@intel.com>, Jianbo Liu <jianbol@nvidia.com>,
 Kees Cook <kees@kernel.org>, Lama Kayal <lkayal@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-rdma@vger.kernel.org,
 Mark Bloch <mbloch@nvidia.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Stanislav Fomichev <sdf.kernel@gmail.com>
References: <20260804083535.2946459-1-tariqt@nvidia.com>
 <20260804083535.2946459-10-tariqt@nvidia.com>
Content-Language: en-US
From: Daniel Zahka <daniel.zahka@gmail.com>
In-Reply-To: <20260804083535.2946459-10-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/4/26 4:35 AM, Tariq Toukan wrote:
> From: Cosmin Ratiu <cratiu@nvidia.com>
> 
> Introduce an additional steering table for PSP transport mode
> decapsulation, containing:
> - one rule per supported PSP version which does:
>    - transport mode decap (removes UDP+PSP headers and PSP trailer)
>      - recomputes iph->tot_len
>      - recomputes IP checksum
>      - reparses packet headers
>    - copy SPI into reg_b (which ends up as cqe.ft_metadata)
>    - set a decap marker and the PSP version in the flow_tag, so the RX
>      handler can make sense of the packet
> - default drop rule for unsupported PSP versions (per PSP spec).
> 
> Packets are forwarded to the previously added rx table, where:
> - one rule forwards UDP traffic to the UDP default destination.
> - default rule forwards traffic to the TTC table.
> 
> The reason is to avoid steering loops. If packets were to be injected
> into the TTC directly after rx_decap, it may be possible to create a
> steering loop with RX packets of the form IP|UDP|PSP|UDP|PSP...
> The rx flow table guarantees that packets go through PSP steering at
> most once.
> 
> The steering mode is saved in a new field 'fs.decap_enabled'.
> Updating the mode is done through accel_psp_fs_rx_reconfigure(), which
> creates the decap steering table if needed and possible. It then uses an
> atomic rule update to redirect traffic to the new table.
> This is now invoked with decap_wanted == false.
> The intention is for failures creating the new table to not block feature
> reconfig. A message is logged when table creation failed and PSP for HW
> GRO will not work in that case.
> Nothing happens on HW without the ability to decapsulate PSP transport.
> 
> An upcoming patch will add dynamic reconfiguration of PSP steering based
> on HW GRO.
> 
> Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Cosmin, can you TAL at 
https://lore.kernel.org/all/0d72c5b2-6d4c-40d4-8cbe-8cd95d61a230@gmail.com/ 
and let me know if this is an issue or not? I see the patch looks the 
same, but wasn't sure if you didn't see my message or if it is a false 
positive.
