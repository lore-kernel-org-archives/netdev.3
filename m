Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4637754C
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 22:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475206; cv=none; b=qaYvrY7MWXa4D4OIGY4R1tJ3eLEvK51QMEyqV87HhGj6w7h4U2dcdWErGc9Lj+gW4fWibFo0vG5Zv2U5G69eCZ2OfoO/0dPJsjscGFBGPmOUXc67K2ABv42wFJwzWZKI4RKAV98P3xlbLaHA70+rqTHctgfS6x+zub4iUzi59H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475206; c=relaxed/simple;
	bh=5Pxnyrh6sJz6yZI11mAbJILgMGo146RRMAO7fza+Nrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u6brJRS0hl9JuBwpGGsrje5o0mZel4VV1bCVd1re2RnguWBiygS24M6nBfXVa4sh69N5Fd4JpmomEznKjUk3lw6MRp7Nfl+g3nK1rKAsijyLxQNPvSklkhgcWP2C/4vZ3LQLJFeS5MKxPH2+hJ5NriNLenO717oOcoS35AE0aTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ggkh0baX; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ggkh0baX"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3965d3d9ab8so252605a91.3
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 15:40:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788475204; x=1789080004;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=WPp0gbMT1TYrxtnW5JU4hPldrwv0MuIGKKP/gzzGXVU=;
        b=SGKcbv4JcegLYsfTrYE1ygbO9lhJxx0W2VLiLcR4UtAUxNLGPsP+mz/04CwEXlOgon
         eGO0CtItP/xbZDjvqDao+2+kXDcV3Oz/jiQYtCEaeMMnHj9CeIOXH6VPlNlNYiv/G1ui
         QFr80NP+S9qcbwW5OAfs9o3FRKjVi2suqUfnVvOJvzp2xJzXIdfSn4n2y2qw5kAodEJr
         xks4fvZMjuIhMOgjNN7JAsSdPNepWE+8iUslCaPKmWvt4k/8omvZOHf+YpZ8zaDw80TT
         OPDmzDWSyo2gSmG9XoYQ27h7Ue75XtIEKCT1E8xqLibaW1dFOuTwAjdMI3XCQT9v9t7D
         H0iQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3hoSG7wDmuHlhXd3Wsho2QNm6eV0EM7Cn6VFrWq+g1hCzROTd7XEau33vtSXh+GPAubPee6U=@vger.kernel.org
X-Gm-Message-State: AFuF++mUX+8NhpU27JBmzqViNDRAZH2vjG6G9xkH+5Gu7+3/OI3Y53Fi
	tF+eRJcA8kHw+gzAVNX8EYsX7YzbaVRzXyiFt79U2cVcVr4Qdk7xWfqCeThXEQ3JbmTgitUx2by
	YftMmqeTHSGAtr/UTRfaGX6Ueiq50Ywg26wvOH2rfa0CtivdKMawJDOAqc9aXZuH37vcEpMFgOY
	LETk17IR7ETTo1ih1SEFikd8T+hoUMEO7nNel3snTh6fHpulzvq4Mq/Ac04r7nfS0Z0aErVoiRP
	4XrQ+cinOND+eEP
X-Gm-Gg: AYBFou3Y0rWoLQu8H6KDZIy7fhn4Fc0fAAdxdKvvMgQfF3ELYIDUMTtNiVh1EEKTiUs
	2e3XL1/W2u22OP7rUkI3kMjIMZcuUZB/WsBLjBqYR2SW6/HEow0IWw58jNXp+ExGkurdMnIXXG9
	4v011jh4a1PPDKb0j1rGttbpNcB3hzt/c08pxEC+C3dMEOvc8wgDF77RpxAnsC+sbZk+1KzWSgA
	JvSiZN1F/CqP2kun958WtP9j5QDHKSyKFgrT/Cb0wyAwYta/63Mw70pClRDOX7lQ0wDekosvQ4s
	92OU6YC5j0c7kYfAItC3/qYprNAcrW9vm3XIvcRitfWcvKh+Y5zyV/DbaquuSIIY6rrAyyuJ+kR
	LsySMKGNMQFhu+3jgxOMNboNfLMle+LjSn8Rp766LJpxBOjTq07Y2ICROxxv+6o6EjNnyqOnKuV
	Vpb2+0qUh20hwJ49La5EyO/A94JU4yE5oPfXL3U4Dz
X-Received: by 2002:a17:90b:2687:b0:398:9c0c:7c71 with SMTP id 98e67ed59e1d1-39b26277b88mr2653133a91.24.1788475204092;
        Thu, 03 Sep 2026 15:40:04 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-39b260deb5esm346702a91.3.2026.09.03.15.40.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2026 15:40:04 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so488225a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 15:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788475202; x=1789080002; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WPp0gbMT1TYrxtnW5JU4hPldrwv0MuIGKKP/gzzGXVU=;
        b=Ggkh0baXoCKDfVjq2HgSzwgIqtb4H2aFiYJ8zZvOiDHCyDGArR0FYDBieDuVH32FMZ
         5R18mhphb05amISf9+sl8pCbZ2PQtXYxe8jElzGkSyT7MRRQLUDQGe8482nOqrdbZGaD
         +iAk6oIHP6+5zJpr5LSYzsytUsN//ikAEFyvA=
X-Forwarded-Encrypted: i=1; AKwUvBx6hk6ZkvWqOjaLZQJej/te9ArAa025oLEyQJw3TH1wR7Jbd250t6Pu3OscnQKRTb3n7T3SgE0=@vger.kernel.org
X-Received: by 2002:a17:90b:1dc3:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39b26207ee4mr2825796a91.17.1788475202268;
        Thu, 03 Sep 2026 15:40:02 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc3:b0:398:d6f4:c61a with SMTP id 98e67ed59e1d1-39b26207ee4mr2825749a91.17.1788475201829;
        Thu, 03 Sep 2026 15:40:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339af25062sm2482783eec.16.2026.09.03.15.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 15:40:01 -0700 (PDT)
Message-ID: <5e1f1acf-87ba-4b1a-9dc2-54f926f50fee@broadcom.com>
Date: Thu, 3 Sep 2026 15:39:59 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: bcmasp: fix tx_spb_ring_full() checking same
 slot cnt times
To: Danesh Petigara <danesh.petigara@broadcom.com>, justin.chen@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, bcm-kernel-feedback-list@broadcom.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260831184235.4133351-1-danesh.petigara@broadcom.com>
 <20260831184235.4133351-3-danesh.petigara@broadcom.com>
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
In-Reply-To: <20260831184235.4133351-3-danesh.petigara@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/31/26 11:42, Danesh Petigara wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> The loop initialised next_index from intf->tx_spb_index on every
> iteration, so incr_ring() always produced the same result and only
> one slot was ever tested.  Move the initialisation before the loop
> so each iteration advances next_index and the function correctly
> checks that cnt consecutive descriptor slots are available before
> allowing a new transmission.
> 
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Assisted-by: Claude:claude-sonnet-4-6 vscode
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian
