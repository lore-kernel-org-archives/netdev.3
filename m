Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498B46F48C
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790093162; cv=none; b=C5a2FJ7PVA+heXTS1Jv6A9RTa46Y07raadOffDIrQXq+l7DkjY3oB2+2eykki7yahkUOffYRcguCVGInqcL9HGw5uHS64y4cuwEA7L3jixvhByixgf5LN/Iarxz5TJyQr49m93WGKbNh/jDkazTw0Qe8JXOYeAEqVNIpnTRgNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790093162; c=relaxed/simple;
	bh=cBEc7uDHaj0F3xOA20DtzQQ/3s8Na+5oIiUZ7+r/aMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uk1nviXbgLXcD9U8LK6dO4Bv1RxXerq48/yrKywhaM0S4sQQk2C3icm6x2BOBAQumMQtZhA6LhegvvNEXFTocWuLrBUaZH5F8Yr7auGIDfPAWMFClrHxHs1DrsaLQ+FwBIeT483GpG7Evo8LM7uzqrEuOKthKNzwfWQgwwkoy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iQurr0gN; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iQurr0gN"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-39de8addbe4so10534a91.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790093160; x=1790697960;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=V0YyTnBog96V9Zb3wGwIvmL06QL89nmCL7iyIr76ijI=;
        b=WkcuiXiq5pKfCl9/uLFcg5vVNkBy/9aqloqybddPE21+SfsYeVzmSkB4aINyoBmWpn
         BDiWhRLZpbZAgdTdpU3ioq2NtHglKWc8mjEFwhpjXG2Mp50rgFuBfgBJjjaxNmDHnmkW
         aaf7BIja/m71ijbuI1/lXavZGNtriyjsLnxE6sxdM6Yu3LNfYfmFmZwKgzEdbeaykuo9
         NwOpiH8Blvc4jm32aZARGqUeoUABTPag1tq56s9aio8xEEguYhVUFdGWRAFe+5gdf+zn
         f6ZBB+epSLhfjxLHzotOOTL7JOcwnaHRcRydF2AqrVMIeYNAG0nJXooRSyo8Pif9VVYW
         r1WQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6rs+kOMS0iH0miV8LPSpDGM3CxbKh+x2Xx/FIAc5D6zUtqxPKmG/p973HRXPs4ORo2aeqkXw=@vger.kernel.org
X-Gm-Message-State: AFuF++nkUYJyT+L+BWPki6SvdPYCPvNj5gWfkk1k2VIfaQ6iLW6utMHx
	ba3Stdo0GjsdcnUwtAVEn1a1jhKRyHOVn0R7pgPvB09E1q+cswDBGtIucI/hPORUjruHJai1kad
	19diIDScKqxzgRQiAgSI8WRnhqaoQyTEO2CBQgvNdEwUppSN6MSSOWDETiYu7GnBEJQgsydADBr
	Eu5V3Bep4UDBwSyIXxQOM8f3mtyjr++xbH66McpOqht38pU9N4EHg9QV2oRsrljsK1dAetPiLrE
	THpZXInL0Z8oWl0
X-Gm-Gg: AYBFou0NgrxNSesndILiWoRxU2VrWj83a7i12kCqSzZSQH9+NuT/3thrFqd1glOdmhT
	q+b0G2hUe+DF38lDQjpQkxRIj+n21mFzBKLEI2/GTLBIOLE6gIjN1qS7G/rdlGUkQLl4ExVPsZl
	R3aul1UgRpX6GzK4h4XFVh2NFeRvNwqOWO7+GGi5Xk7iC5byEV/v0fp8ZNSt+oshvv9VwFZQkDh
	pltXL4EISeBiwNyf5Bv68UmjUmxm0gkvQ+vK+VP09viUvVPrMGXZrHaXAeXWTGrpKl51P4I+GVe
	qufYFbHWgyBFJ1uUM06LY5f4qkxYMbwux7x+LsM5Kbms+QpnJuwIztWlfOZ6W0zL4mdQF+k/zse
	p/mweoSc4I7KH3uzRNAyRwz3aOCJHUZrtPzf2Zc03qD7RgjD61jxPYRM+PCiwKVWaynJGsUPQ4I
	uSqF70+nuKFr4N6EQkcLYoV1tXCOMNliiyGbxzBOAq
X-Received: by 2002:a17:90b:4b:b0:39e:27e:2f09 with SMTP id 98e67ed59e1d1-3a07309da84mr1898188a91.8.1790093160323;
        Tue, 22 Sep 2026 09:06:00 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-29.dlp.protect.broadcom.com. [144.49.247.29])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a07db71d7fsm43393a91.2.2026.09.22.09.05.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:06:00 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-530d912b923so1096661cf.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 09:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790093158; x=1790697958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0YyTnBog96V9Zb3wGwIvmL06QL89nmCL7iyIr76ijI=;
        b=iQurr0gNBLdYSeTU7SZjD5/BU1k+oQF3YLM6oWjK0JxRiJdlizXhpGJXXz6gBY889a
         k0CVcPtN1Er353LwBX5uT0tYXC9z+J2ZoLV+oH8fHE2ps6rZDEdlztNUyBLC0D9I4Lfv
         3xOCWot60njwXmMWgFxDN3hHkLyU0llz/oDZk=
X-Forwarded-Encrypted: i=1; AKwUvBxXdXXLzdFJWsnsg9mNNOWi5j3b/CqhaKLb6IakZUNZUjOV15qOwo1dhuKa+b2hkyiVur8i2Fg=@vger.kernel.org
X-Received: by 2002:a05:622a:14cf:b0:530:cf10:8a9e with SMTP id d75a77b69052e-532eadce263mr614881cf.39.1790093158004;
        Tue, 22 Sep 2026 09:05:58 -0700 (PDT)
X-Received: by 2002:a05:622a:14cf:b0:530:cf10:8a9e with SMTP id d75a77b69052e-532eadce263mr613981cf.39.1790093157020;
        Tue, 22 Sep 2026 09:05:57 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532e18c5ee4sm16133671cf.11.2026.09.22.09.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 09:05:56 -0700 (PDT)
Message-ID: <faea1c6e-1317-4771-9096-75254877a810@broadcom.com>
Date: Tue, 22 Sep 2026 09:05:52 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] MAINTAINERS: add Nicolai Buchwitz as GENET
 maintainer
To: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org
Cc: Doug Berger <opendmb@gmail.com>, Justin Chen <justin.chen@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, linux-kernel@vger.kernel.org
References: <20260922073140.1471858-1-nb@tipi-net.de>
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
In-Reply-To: <20260922073140.1471858-1-nb@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 9/22/26 00:31, Nicolai Buchwitz wrote:
> I have been contributing to and reviewing the GENET driver for a while
> now. Florian asked if I would like to formalize this commitment, so add
> myself as a maintainer.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for accepting Nicolai, welcome!
-- 
Florian
