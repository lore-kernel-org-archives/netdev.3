Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792510730;
	b=FLhZP6Hx+SsN8UA1IgSsKyTg6TFnfMZWN8EDyRXBoMvfwhK4CPsltZm95IipMNuQ3GiJ
	 l1VseaBihvyFHqnSse48g475dK5Ehwv01I1K9PAEGUVR6DUs2H6ydFvLg3J9ZyLgcln5W
	 NdMnFt4oSGSdkUzeB/ZgNDD2LI1CBvgCRSmG/FOdvKFMjvTIWgtWpT/yj+EG7e0LKn9bx
	 wJn9LdpkTMHFU2MuMT0z7bVzonvbRAc7JK+EQ4GweqfYgdseu00yKlcfyr9jt8TeW47yR
	 MYuS7eFw3Dim5qBf7uo3foS/x5M/fnbPEbly4OXBs68x1jNb7G1FBykMJBvR1azPx3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792510730;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=djXZskGgNuwcvXxJ7QSBd5G1fQCIwJ3UJCCUrLYgW60=;
	b=kU/CaOzK8srHTxYtZV6VIyRIRyokKbJu3D9GJUGK4TlXWLX2wtua76WL54Yt7HfLlhlQ
	 0iBUumN3Q567RN0g05nkEa70NZohfmE/1Ek9ZZ5KH/QT3HkM8PoYV9PzzM/RtXc06yZlq
	 P7L9q6cAtJ9Fst2irETKvQ5E6p75vzWWJVG1qfWt1IV+1DJuIG82z8aFqIrW3ycKsQej5
	 RW9fY5gQPtKLD1W2iUjmc/A5yKkr0SAfupDqfANzALeeKHFrvHLndpOOnDm8I2ytoyVqf
	 M3Yt9cV16qmeOpxUjPQauSnFS4fmQtBQrCtCxY6D/P6p7DbaHdIUUdAXDkoNGmxYXjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=O0IQqfGc;
	arc=none smtp.remote-ip=209.85.215.227
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751A160A2611
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 751A160A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=O0IQqfGc
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-cc4dbcf2b85so1394015a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792510729; x=1793115529;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=djXZskGgNuwcvXxJ7QSBd5G1fQCIwJ3UJCCUrLYgW60=;
        b=Vwe0iWFo7DuTmC8VPDKtqCOcp2JgYEy9dH8nEX83SN1P6JOa9sb0r74/BzW6vjp14F
         EfThJWzHgTXhhe0ltQ5aDdP4aTXg6uJ/i4cpLdM/1k7jE71L7P/Ct9tOlNasnHG5lUsB
         vNnbAAl7Ny+eyump58dBpWh4wNatmp9bsujKf+99MTIC5RXDaWDo2OrAttiGmGk74T/F
         uiYN6Kd1j0si+jbAX8ean2VHID7A5Ws8ACj5sADC+lNBOXPJhHliXzA51UtPXnEZHrWx
         lCt1dHQr0bnXN18O5tk8OxTE5ZFQ/JmQs2N9JXRTIQWo0K8t8UfrEgVA+vPRGa19eQsT
         e/fg==
X-Forwarded-Encrypted: i=1; AKwUvByXZq8yu+Y7z3pXFGnHPmrr/IgEuHJFMys2IKcyNlYVRgaot3jaMjkvjlvVcZXP0zY0JjDZ5DA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJZxShZzxex8v68iaY59IfSmRrU4qIZF6SOWKj3xqjwBYISHPL
	OshKgw7F2uDgMhZDMGKn41F4O3fRHjnimL1KrhWBxiYunler9iAiVRgdzGH2qfoWa99AzxRxQjQ
	Rn5YTZHUiSaCi19XRfGvJXgVQECgU07SqpKP+ATZNMAbhXLaSDF5UW7AG8gz65N2qZIspF42cts
	9SAlrGLczlMH67rMT3ZTm4ySmczFJt04TISIR0ngSzHrwigWZcNdc3cO3pzDF5zG/uYrB5Todeh
	qoSQeOBDX0bzbwL
X-Gm-Gg: AYBFou0KbrMLs9jQprYKxB43Xmt4bYvI0N7YbHl2OIsax0W63p7Pa75dt1I4OzAPVzQ
	Br2+0sHqV8gmWp6H6p3yTwr7pPFFXUt0/NZb85QbcF0B/KtUAwZTCiuNWDp2A6ZNfoBXpG35Y3n
	o7hZypuQ2JacNMI1na6zDgshFkHLX127BdfRG509C2PC1/45JD9pkYmrsXeYqa4EeYICf6DK2HC
	GNvNd3UVxiOBYjYmaRDdVIvuITAATIutWN66dm4kVONFQGd/V46i7alDNVWlgqdNZBFSMufCiGn
	Yus2QC7qsjKlEDScDBKL/jxGmF5MzKCmHQdTlDpD7ia536bIjxbQNB8HIunNKfYSDmjljhBIHnd
	IEvd8l/B1qx6LtEin78GV2gZUUAlNCxPk8uqZK4PwWaqTb6zOc2o3sZ4MWd72m2W5Ht4mTsJ832
	HvTWZtbgmr6hFtBPbDz9s8s7Ba9Zx/U3XXal3rgLfaLAM=
X-Received: by 2002:a17:90a:e7ce:b0:3a7:da33:ff2d with SMTP id 98e67ed59e1d1-3acef591b93mr9789122a91.48.1792510728819;
        Tue, 20 Oct 2026 08:38:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ad273c2779sm2323443a91.5.2026.10.20.08.38.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:38:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5363fa3d3e4so70465651cf.0
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792510728; x=1793115528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=djXZskGgNuwcvXxJ7QSBd5G1fQCIwJ3UJCCUrLYgW60=;
        b=O0IQqfGczEPPc0jVZywGiArcgAVLjhWVYg7qISyYsTdQkV4BK3rRAhMYpDyWVZXnvd
         dp/imrnN1A3bLMDgKOQ2vS1pdcKmTmUPF2s9EHNbDNuxIfQ2+VtLdk6v4eOilvxG0xDL
         0WEpdf+ZLNzD+5DLC4HozRRthAcpQeWaFm4ag=
X-Forwarded-Encrypted: i=1; AKwUvBxxrDivaGdYuNe13aMQUe9Z1Sjdc88GtJ9tSm+TGGget4v9m+P+jfggwI/bg5qEKpGrFxdBvlw=@vger.kernel.org
X-Received: by 2002:ac8:5e06:0:b0:536:4cce:67df with SMTP id d75a77b69052e-5364cce6af7mr160757681cf.54.1792510727553;
        Tue, 20 Oct 2026 08:38:47 -0700 (PDT)
X-Received: by 2002:ac8:5e06:0:b0:536:4cce:67df with SMTP id d75a77b69052e-5364cce6af7mr160756821cf.54.1792510726868;
        Tue, 20 Oct 2026 08:38:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5367b3d1ccbsm36400461cf.0.2026.10.20.08.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 08:38:46 -0700 (PDT)
Message-ID: <f918c40f-f073-4ba1-ac4b-7765c42a5cb2@broadcom.com>
Date: Tue, 20 Oct 2026 08:38:41 -0700
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
Subject: Re: [PATCH 1/3] dt-bindings: clock: bcm2835: add the BCM2711 GISB
 clock
To: Nicolai Buchwitz <nb@tipi-net.de>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Stefan Wahren <wahrenst@gmx.net>, Phil Elwell <phil@raspberrypi.com>,
 netdev@vger.kernel.org, James Clark <jjc@jclark.com>
References: <20261020-devel-bcm2711-gisb-clk-v1-0-a1728724d0f8@tipi-net.de>
 <20261020-devel-bcm2711-gisb-clk-v1-1-a1728724d0f8@tipi-net.de>
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
In-Reply-To: <20261020-devel-bcm2711-gisb-clk-v1-1-a1728724d0f8@tipi-net.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 10/20/26 07:58, Nicolai Buchwitz wrote:
> BCM2711 has a clock generator for the GISB bus that the firmware sets
> up at 200 MHz. The GENET MDIO controller runs its MDC off it, so add an
> id for it.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
