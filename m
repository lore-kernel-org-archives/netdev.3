Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522159;
	b=HB7ERXDEx2WBT1KDluhs7akO+eiD6DLTg8lO9HD6KAHfi6qoatLxDFhBA7kVyqN1JNaC
	 Lbmd8Bw33z91vZab5mPe98NIXVJvKv96U+5Hp5UdXROi0WW9cICeftVOs/M65FfWbHdcM
	 efPP5FULxAhBHn9cr43+IHEsP12n1ku3mnJgCnz1YBQPIAtMTj31wU0uK7MmBgxsmmLJA
	 /FF/DiFASJ9CI18+Zd6Hhcc+o30T20QD1KSOdwl348jtq/0v4sNI4wFf8Lxot0DShyoXM
	 1cMo0GUTenSVbyzm7YGsk9wuzx/z3Ny5X444mNLUWfkTsYTI6+bJu+m/7h0e5EZw2gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522159;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=+q1vn1hShkCKGydXxe5nU9m/qd7sW0I7os6nazrrI7E=;
	b=azTesjzjx7ZSSNflFPmGrHvlY2/kInNU3fwLhP1d+ytSltgGMTygkD/TNCAco6QZJVXa
	 hBV4WWvFPea5u7Kox4r29UJWzHmXCwnhk8NB6IalvgiKo2cTX+aNN2+ywN2G8eA+OVsFT
	 Ae725F9HP0B2iPml9KM9kKtK/W3gN0d7k1i7b5V5D+UHbh89AxTTiCGxbn4IRKiUT43lG
	 KJeTJW+k2kSvtfvt1wM3SxpGA6azg6pSN0bgzl7MKm5mML28/6uGEvEu9FZkKAT8XH2sO
	 Yd9RzqwP8WqLT/Nr+IaO3RAMNRUCI2KXqw3qPG98zECx7IlrTipqXnUP7u08mPf6iLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aqax2RMd;
	arc=none smtp.remote-ip=209.85.215.225
Received: from mail-pg1-f225.google.com (mail-pg1-f225.google.com [209.85.215.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0005F606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0005F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=aqax2RMd
Received: by mail-pg1-f225.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso147583a12.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:22:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522158; x=1795126958;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+q1vn1hShkCKGydXxe5nU9m/qd7sW0I7os6nazrrI7E=;
        b=TMPFRF3NiqzOfO4juVk70RNpLXXMSc6t6OOuOAyRsF02AJRYUNQplMHJu6HxAZ2FUa
         b0bItNhZkEuuRjh+1qqxHecbtvv7sjp9jwQhrTnEEJA0p5CrJE3Mw3xQvHZ+V4Qz5Ee6
         551D0dNKi4i37mxpPdpwwuTRp1ZyjIAV9FE1YLk6JE8BmRz9457c1VbBv++O2Jvpf26M
         txuyiuykimGDM8pN2NeeCQy1rD/DwPH2sMwHxcBypCr7S5mV7yeyXRpDCbKgVn1oo2JR
         P3Axa+LKsigy7vwHP1uuUUu5c8zZ84j8RHid/JYkf0+W1gYxmgBSLhtKF0Nto9u8VFx3
         aR4A==
X-Forwarded-Encrypted: i=1; AL+hErE8+Tk48H8AIWT8FUSvxlguaxo9AS1fk5G9nbqlBap65TPL6Iz7MDZawteUf2lqzFqnB9M/yTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4eFz5V+AmEt28RMNpZ5EHyTIaUSMov6VMLiedJgtIO+JZODNY
	jTvamLWSwLSgTG+4+NCNSQ4WnvsAy9A4Lg7juAQnIIt4T9j+64wKCEU7ziHv1Yk9eyFEwPLFK0H
	q5Cut417ShuLo+flrxdHRC4M/fQc4nCslB0kPAKqIEtp9rpCB+9d1yPAoxxhaVEe6wmullFs82Z
	k5UP0RhdhU17HaZLyxkzVJ65hDSJkZW1H3qNV/zkjUE6OcoBzsDMWAq5jlVoaTp+6VvTyOaoBqQ
	Ps982yTPQukMntR
X-Gm-Gg: AYBFou0hUNPXiR66o6iCeNS9aw0VXoT/e5uBaCCicSap5OVJ4lbhmFrbmuJ1rj+Ph5P
	35UboYjxKFcNQgxTKbtNgFmWSp6FA5tMCx0N9chyV4571Nm4vJp13siL1Ia13oe1R104POdyWwn
	JJ95c2JdF/8rDu8PkuDQDyLSlcEhc8PS21FIK87JDAr2YILI/GTwuGOdTKPARQg4hrOWeJKPXL2
	+qHs+QuvJdPXz5h57QXguopmzT5xij8FuBWcltvWnK0AJnHq14UpKo46k588DVZcjT/4xemQ71K
	+OYZuDz+9b8HXZUGEGtFdIMERghLEfRCC7mxkX9IQYizZ9DC+iq26ra42NprkkE5UBQt/PzirOW
	Aw6jmBEedAiYdTlxFM9Oxxt2qHMjDZjFTs5F7v4FKnx2QHHqLQvX4BZRXMNSkmo0FF57m9OJmvf
	qtk6oNrM8EI8ewwsoA853bS/zXi0fiVHiwy66RKxJX
X-Received: by 2002:a17:90b:4c11:b0:3b0:a3eb:759b with SMTP id 98e67ed59e1d1-3b1b0a42bc7mr405849a91.23.1794522157974;
        Thu, 12 Nov 2026 14:22:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b197cdf4dbsm3928474a91.8.2026.11.12.14.22.37
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:22:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36f26e6abe9so378988eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794522156; x=1795126956; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+q1vn1hShkCKGydXxe5nU9m/qd7sW0I7os6nazrrI7E=;
        b=aqax2RMdzVDdPWUbIcapkUmgBGc08arZbBnXRMz2/Xo0P4vK0FNKEfdYu+JcGrh7RC
         Kj3eKwSuyw/IvHY1cG3i3NCQsMyM2ock80T9T8G/tbSojdroPIQaIhOvOsX/Haqpnr3u
         6R+QLIuj2iMNdT6YqCxsEHBvuQVRsETiuM4IE=
X-Forwarded-Encrypted: i=1; AL+hErF4s++RJ8VNmw5VJIoKVrlAl6QPvjVBBMPJVuo3/V7ASZfb/Fsd3D9qjS2FkkY3rpDPbWsqXIY=@vger.kernel.org
X-Received: by 2002:a05:693c:66d3:20b0:36c:c434:b6b8 with SMTP id 5a478bee46e88-37966e3afa3mr453944eec.26.1794522156235;
        Thu, 12 Nov 2026 14:22:36 -0800 (PST)
X-Received: by 2002:a05:693c:66d3:20b0:36c:c434:b6b8 with SMTP id 5a478bee46e88-37966e3afa3mr453922eec.26.1794522155473;
        Thu, 12 Nov 2026 14:22:35 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563e6b6dsm2846867eec.21.2026.11.12.14.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:22:34 -0800 (PST)
Message-ID: <15a83cef-3549-40a0-a8cb-0bb9234276f1@broadcom.com>
Date: Thu, 12 Nov 2026 14:22:33 -0800
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
Subject: Re: [PATCH net v2 3/6] net: bcm4908_enet: release the TX ring on stop
To: Kordian Chmielewski <kudzo51@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261112195051.597102-1-kudzo51@gmail.com>
 <20261112195051.597102-4-kudzo51@gmail.com>
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
In-Reply-To: <20261112195051.597102-4-kudzo51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/12/26 11:50, Kordian Chmielewski wrote:
> bcm4908_enet_stop() disables the TX DMA but leaves the ring as it is:
> the skbs that poll_tx() has not freed yet stay mapped and are never
> freed, and the descriptors the DMA has not sent yet keep
> DMA_CTL_STATUS_OWN. The skbs, the socket memory they hold and their
> mappings leak. The next open starts the indexes from 0 again over
> those descriptors, so the DMA may send stale frames from before the
> stop, and if the first descriptor still has OWN, start_xmit() stops
> the queue before it enables the DMA, with nothing left to wake it.
> 
> Wait for the TX DMA channel to stop, as is already done for RX, then
> unmap and free the skbs between read_idx and write_idx, and clear the
> TX descriptors when the ring is initialised. A descriptor that
> start_xmit() is about to use then never carries OWN, so drop the check
> that stopped the queue on one. The RX helper's timeout warning said
> TX; make it say RX.
> 
> Found by reading the code; I have not seen these on the hardware.
> 
> Fixes: 4feffeadbcb2 ("net: broadcom: bcm4908enet: add BCM4908 controller driver")
> Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
