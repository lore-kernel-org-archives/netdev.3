Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036597;
	b=W7Upi5BKuZ3Ytz51brZKM5s9tMb0pMvA+irsRlWNcrl0ogLE/QIPa8oPZbKQwUsqtbwI
	 AVPsDm2Lb+03wuyKs6gBOdrSA6h9ZXD3WLdNBc6W8Nueu1o0DPWBtC7vL7iTLmNGgGkQ9
	 Sa/CiWQRqkmiuBA1Z79HswFL013UrvajP4c8TriVd3KIdOc+f/VSAWB8/w6dUO99VXFBN
	 Nq0+kCRYPLFKTXvwY4TYFq8TZIwh1c+dBSieYpEdCW9FnBxrTOs0uvwzsEQcOqg79zPMN
	 yICdYrg5LP9xsc9caDtZlxP0u7CRtztdMiHegY2rPrdTbaKIPm7qrFO7/a3ZAkjOPUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036597;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=OHaZUdtVvLIKZuLrM7Y3bA4uX2LmsUBAZgFw/YFZnmg=;
	b=ua6dEI6Us9SbNSMVB3RCfAezDfUwhNUw+XKevVS1zpwCN2ph2wGUTyxh+1XKghGFiVW7
	 A4pAWwpP4QOwY8HXI/sCI2ADxslOt5vy3hSTU3SR+g0k8RUCgvLF++6H4wAYhE8iAhO2x
	 0sebHNP+adX+xkzouNVuMEi0QiTjQU2eHdPXPIhZwpZ+yIvPaJuXbppTrvvoQAwyhzxz+
	 C6hddqdwJrfH5ls2VHvq5f9l4/V3bmMiWIrC+iYYjezz7orUD2SmQcbRTijuqWVZxb3fw
	 v43agYCNVClenMZ7kFJ/gd8DMKT/4JY+HRI9dqnm/yajEZvVAsm5Y99y5zLrUfP15Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hx8hYDUD;
	arc=none smtp.remote-ip=209.85.215.228
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80653606A31D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:43:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80653606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=hx8hYDUD
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc758830601so2024602a12.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793036597; x=1793641397;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=OHaZUdtVvLIKZuLrM7Y3bA4uX2LmsUBAZgFw/YFZnmg=;
        b=pcvHcdeqqW4gxVl4UoMRf4759ipD4n+tFifgqcA8O75Oo+fKpTkXEef1KkE2z1pojY
         vEim0PPdWmLBcvnVAAn6xSdIu/KKfcqQurVjTObl4Q1KwGXhMRY4O/44BWo0mLWMfWry
         iEiiKevSV1sb1Bx3fV3LtsoOpZV2W239DtGln83vVPzxn0kocFjCRzfE5YA77FtfOIFL
         xwwG2rTe6vkyJQFbGIH7V/RKgqeUbseNv7T9LV+8bR0oWB0Un8px2tlJn/MHCRvQWdiM
         F/z42FTji0HEpAmMGxEhMiL6hUKKPBh9wm7NJY718pE14EPJqBZ/DjWIRM84UbKiFabF
         s4Ag==
X-Gm-Message-State: AFq9FYJzCZdLpoHSyVefQ9ZEDvPmAzJDHle4Nw2AasP41uG1nqZ7B1IK
	bc9Qz9eADoffFnwAJkw0uJTGpVq8fFdS4Io4nyKCtLiK0x8X8Vjatl8Zcs9MwwN4obuM9rcH6J+
	ekNc4oCyEuWwqG1bJHN/D361k/LpP5tZJADZLq8a0E6q5NTu/nBLRTMJX6T7k0wb3TYbzhnNcSP
	7KMFkme7ycS/i/ueMm6r0U/KFm1NCB/3IxXBi9NDsxTCvpcZDi3RC7pD2hbivocL1FnsH9Ylc35
	agjHN2OjtPqAEulNr4=
X-Gm-Gg: AYBFou0D5wN8wij5VxP7KrTPy2toKckmPKdryE0lXgOqR0iWGV46F2rwpCmhXOuoMMh
	FhaYObmclhSRGcV1FUEVypSVdiu8XnolCqqdFCxOVbyXL4Hg3JijLGCK1EReCZH62egOp33YaIG
	98M1dyhrL+OYvSc2Hb+l+m/u1iS81yHiBJSHars8jaAvsGjcswwdneHhOSKfplZQSBYGGT5a34V
	jrwi8fTw4TU5akByrS0mqe2P8/oZmlxFyAc64iv/oVEhd8aaJqHpqdVInbGhUOjs+vp3vuHauXl
	b/GrvByTCvYlpWw1qedvG5UGl6X7bxauIGP5e88YBTh5ttM8LKw+dyjxRJZTOvr3XiDgxPFb0yA
	zEdtxDYN5jFX0RxTcJujPedNb3q2knB85RuvAlNHjnyyPtc8VOkaC34qCyL/cLBIxs+HLl+PM6P
	LASkEvzP5m6ZY/Lwd6ld3UddTgzQNyTNWOlWkzaEtZ
X-Received: by 2002:a17:90b:280c:b0:3aa:ff19:42b8 with SMTP id 98e67ed59e1d1-3adead4792bmr6147386a91.27.1793036596900;
        Mon, 26 Oct 2026 10:43:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae405f13ecsm180063a91.4.2026.10.26.10.43.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:43:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-154e9d2d94fso8115657c88.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793036595; x=1793641395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHaZUdtVvLIKZuLrM7Y3bA4uX2LmsUBAZgFw/YFZnmg=;
        b=hx8hYDUDbQMdB8zJJ2Kt6OX/aAqU7rftvA8CylS6alcMHNsLWc/Bj9AMhtuGlobUOM
         tHdeu+g2MpeiC5JpCK+RCVjvmNhAksiO0An16kqnRAUSUPNyR9+k/sOyKzKB4At4TwJj
         XkWU/heWdT7sgARWOuprPTyHWDrJSUv0VNUaM=
X-Received: by 2002:a05:7022:5f1b:b0:144:eb46:c3f with SMTP id a92af1059eb24-199298b3805mr10923556c88.2.1793036594769;
        Mon, 26 Oct 2026 10:43:14 -0700 (PDT)
X-Received: by 2002:a05:7022:5f1b:b0:144:eb46:c3f with SMTP id a92af1059eb24-199298b3805mr10923522c88.2.1793036594027;
        Mon, 26 Oct 2026 10:43:14 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5937dsm25813540c88.20.2026.10.26.10.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 10:43:13 -0700 (PDT)
Message-ID: <beeb31de-3820-4276-a322-277b9952485c@broadcom.com>
Date: Mon, 26 Oct 2026 10:43:11 -0700
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
Subject: Re: [PATCH] net: dsa: b53: Enable IGMP and MLD control packet CPU
 copies
To: netdev-bot+sinfo@kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Jonas Gorski <jonas.gorski@gmail.com>,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Vivien Didelot <vivien.didelot@gmail.com>, linux-kernel@vger.kernel.org
References: <20261026172453.3152951-1-florian.fainelli@broadcom.com>
 <179303585627.3327.17394761075603736161@kernel.org>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <179303585627.3327.17394761075603736161@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/26/26 10:30, netdev-bot+sinfo@kernel.org wrote:
> Hi!
> 
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>   - How the issue was discovered, e.g. hit in production, hit during
>     development, syzbot report, manual code inspection, LLM or static
>     analysis tool scan.
> 
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
> 
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
> 

This issue was found by using a modified version of Andrew Lunn's 
dsa-tests against local board test (BCM4708/BCM5301X with integrated 
switches, applicable to all b53 support switches).
-- 
Florian

