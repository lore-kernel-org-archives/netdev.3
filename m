Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522060;
	b=3vgMNyk7vvZLu7ZcjXo8F0+N+aKplZC//vcm98uPeVIqUgque2KOepicyhHf8CRaipZw
	 wFDS3p1ESkWTGNP0Vca7poyaY3evBLzUQHFBYizMKr932WdbUaSIN5HBx4MJx7Df1vB1d
	 R2XE4etSpPEf2tAYWeq1ONyl+1gsF00lmC41n+6MdsZ23FyD7DlX0/RxGUa+Fye/QDDJ3
	 fHweDbrUzLsxVQghb9050WxFItooxN6jDLlIQXyowfNjHJQ1Ndj3oHdmkTBSPy+fs9rkL
	 zazKFI1+jN49DmiqIKPXmYxxmbQx+VZMBtbE84+tOroKSDjFY6kvKhz5jCxlX/QzhUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522060;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=+fJZVoPcPX/ONJ9AsxeeWQcx7xzpx+S1dW2PWwFnYJc=;
	b=hwYmo/EGArMjnfdW8wi/B3U7o/DPa7iu3lHUUU6U8A3TsSjzNXCbuhCbjhQI88QtZJLn
	 Prye1dNwb8ujU2SF8hkjK9aK3QyMxnu4YbC18AKwh83zjNnGB8t81ftgPQwO3Ca59yijc
	 Znf3M2XqJkYSBhz7HWrJwHQw2ZbDtePs2eo/Z2k9UtKcNZ6Ou5tVxvH24XdpKFdaK2h+H
	 MURAztymEOozOX/9HPL1xpSJhwzK/PlOniQyYDLBDbBn5KzllrIzIVVBs7Z7nFy9HuP7V
	 IFWkVi40j2qvAIlrYm0oVFh6ejdo2VsZlw5IqJeQI/Y/Fo7mWLeGW5xpAkEjRwoVeLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DVlH4upX;
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A759606A327
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 22:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A759606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=DVlH4upX
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-93f269e335eso43144585a.3
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:21:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522059; x=1795126859;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+fJZVoPcPX/ONJ9AsxeeWQcx7xzpx+S1dW2PWwFnYJc=;
        b=Jmuy8pkKEhMokGJXldxMT1HZxtS0lLk1w6aGvgO31CZuOofKLRcvEItcXxJEmNJf0r
         G7wY6nW8SjLBVpb4vRdyJmBGUpd+6z70uZezcWESFy4Fn4qwQgjdaJHHopbj/XtFgLcj
         /X6BvRR2loaShChdgyhm3tmI5A8rbZ6FUZKEL6FeoMEsaoERcAAv3ve/u07k411TYOTF
         ulbNF096NdILqSATxL+Gyw3NeKuHcl2iRYVEDsLr8DyQ47v4+gUreygLHG5W6zqWifdM
         ZD1JX27iIKPZKTUlT8NrachSI5M88ZWkIhglVAa3oAV+ln3N6OaexLWWLF8o0kCnzxnK
         jFbQ==
X-Forwarded-Encrypted: i=1; AL+hErEk8E/NDAHk6kGUqT2xlWfJgZE+tp4TowwY+XQURUOL1j1PB4GQ8KFKxj+P4crR6/WphB18dfg=@vger.kernel.org
X-Gm-Message-State: APuU4Z96L+HkyHWQCd/Tmnz1s+hWWTxckRyjUzHpvl90asrIYbcNyTr4
	FGQKXz2kIsj4snoxG3oKzgYevnY5VX1gbSwv84ap4ozfLGqWflMc5SKz0cqYsl2J6Egmy7tQd9t
	wtHH+u28bJcDL4YD9GSCAwmIg1syq9u7DU5n1GDAgTp8L0yOxOzJN7UYOpXfAR/osfjiOqpLaMj
	4hpF7MyzRZs+R95BHNBlh9W+nIQ180u2SS7bpgO8sexquHNW9uDkjr7Tj7+sQea0uIuWWHrXggH
	QNEi/2jToIrXU9C
X-Gm-Gg: AYBFou2WU9L2SHPSvRjpSey/m69Wz82Qto5Q3y91Wr/zCy/TOg1rfSqjCVlMvGBdlds
	LhDT/spr10ryHeWOn1osK5ILtXpWDiV776QZFP0Hqn0OFfQFCR+ToW3ICAZZNg+8CKMz6CLJNvm
	l0xwZxMHPfCdwbO2Gyil/x3TipzSDXa7Srlkz+mkOV3DWNfMzMH06wqORjPlYHD1cshBj8p1Sfa
	87NDia30Ly6Z2pVmn9QFcQOBsVqjlRatLqTWirPvMkWo0auyKEZ5MPF7Z05DoaN4JIidCb9MdCy
	CLcGalgDzZ4uG4c7SaRq2BDMyTpXp3UkxVxYaDOy0wMOfAG42RbyCWW+Qf7MhJILvEoXuKeLzn5
	CNOGhVNjVCKasVsc6n03fLOtLpc7TMZzRaFHolUbQwN5V7+/wB+SpF5h/uE+IdTmvg14n+LSCtp
	j+T7s3/d6cedDnxe178aDwKGYyqEBirNOF8kkULkdO
X-Received: by 2002:a05:620a:2811:b0:93e:fc02:e8d4 with SMTP id af79cd13be357-9494bb77a72mr135337985a.27.1794522059231;
        Thu, 12 Nov 2026 14:20:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9494c69953bsm12060985a.10.2026.11.12.14.20.58
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:20:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so514574eec.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 14:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794522058; x=1795126858; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fJZVoPcPX/ONJ9AsxeeWQcx7xzpx+S1dW2PWwFnYJc=;
        b=DVlH4upXFjuYcDg0HpkpMRF0gviR5iNLCuMWxTGxkVeHYq7LH32zIhknrEdQTIvHnZ
         uDkTrowa8BUxv7qrfF9CCPzZFwk9yEoQVlk9vcBJbShgV65//VLUEKyn4qrJt6NSouLw
         AJYa0ixqwfsqoJDN3tvpOf3cYEBtQVTNpMhok=
X-Forwarded-Encrypted: i=1; AL+hErFVwlb6MX3uXjDaZ57spnLWOUfh9sqbYvMEIVDpKDAsPLMJUSTJ8jqtF+ThodjDBpRfK9dBsuM=@vger.kernel.org
X-Received: by 2002:a05:7300:d58a:b0:366:83dd:46f7 with SMTP id 5a478bee46e88-37966291a49mr604002eec.17.1794522057906;
        Thu, 12 Nov 2026 14:20:57 -0800 (PST)
X-Received: by 2002:a05:7300:d58a:b0:366:83dd:46f7 with SMTP id 5a478bee46e88-37966291a49mr603982eec.17.1794522057222;
        Thu, 12 Nov 2026 14:20:57 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bb0c40sm1264958eec.28.2026.11.12.14.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 14:20:56 -0800 (PST)
Message-ID: <fc3fbb96-92e1-4161-9539-5241390a2211@broadcom.com>
Date: Thu, 12 Nov 2026 14:20:54 -0800
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
Subject: Re: [PATCH net v2 4/6] net: bcm4908_enet: unmap the buffer of a
 dropped RX frame
To: Kordian Chmielewski <kudzo51@gmail.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, bcm-kernel-feedback-list@broadcom.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20261112195051.597102-1-kudzo51@gmail.com>
 <20261112195051.597102-5-kudzo51@gmail.com>
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
In-Reply-To: <20261112195051.597102-5-kudzo51@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 11/12/26 11:50, Kordian Chmielewski wrote:
> When poll_rx() drops a frame (too short, or not in a single buffer),
> it frees the buffer without unmapping it first, so the memory goes
> back to the page allocator while still mapped for the device. Unmap it
> as the path for good frames does.
> 
> Found by reading the code.
> 
> Fixes: 4dc7f09b8bec ("net: broadcom: bcm4908_enet: fix RX path possible mem leak")
> Signed-off-by: Kordian Chmielewski <kudzo51@gmail.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
