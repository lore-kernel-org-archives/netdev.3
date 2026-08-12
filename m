Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF9A3469EE
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786566262; cv=none; b=klw+tsqdP55O/hdg8C2113Uhgs3GDOCZv9N5i4yqvhJ1l4W5KWmmfRd5hsy7nmdWWWcBDD6pBJAfZXsf7pY/isc+2aATzQzcSIATnE0vtUrxs+oPV8lT+n7ULfKX3bovbkLNPbHqrPFqNesG/hc5qoHx9WtxF895PQ6qSbAncXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786566262; c=relaxed/simple;
	bh=i8ktCy2GlL0xTxDMdbz8Utu9rRX8YCUyaxzKr/VT31w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=af7Hl59D/P2lp1kfBxDIg+h+pC7c1gHli7itoAXEF67EdvUySoys1BRhCb/4mwWDC2YUp0y3KALq1nMTglpLBikqpcz98hiXFvVNvuZQMdll0I2gagKFQ7czkt4Dk3MhvEkT9WsDzS+cpIDECjFUtsh/0kJtKhgRhEsOGXdg0Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G704KI8O; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G704KI8O"
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2cca0c5799eso18020645ad.0
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786566260; x=1787171060;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BZtZnEw9abfd2kfAccbrrChpAaOCNlD+RCF2EVqOizI=;
        b=loHrTHMD+YZnF0x05llgT1jbFugEVSWFat/y9xyFpx02VLex827Oli68PVL73R1ub4
         zIiWbVNhNqVKtsTxf1U8IHBn4hG80v8Vq5q12e6d6wvUliOHOeUwU6MV8w5HdzuTq7rR
         xrWxzkMaCVG47AYrJBvuxr498nxHjtlZM/t9xmPUW7hfJkWrTIJ6Lp+DhDtuzE8rq7WH
         M6atBsnMqwZlBLur5rGtWaRyb7+n6DXZ+frETHRRNI5w4gC4sUjSIbLumADrBYKbzANr
         B94jZ6t6drznL0YWaNyODDeFxTHkPPo3ZSIxFUpf7ZofOiiLCH86za68LKOuRldVf16e
         hClA==
X-Forwarded-Encrypted: i=1; AHgh+RrkudGVWSVd7t7xWTbM4BYANenGmpXyBeju2t+WOtoqoBk4Zk2jH1Qee5FEQTIcw5Q29Jr9Ow4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOTkqs58t1P17GA3txgmhl6h/IDW3KzHC0elPAAiE/y4wLtcRn
	5wIdhbrWqiYGHtqdxGoOLyP2yJI27iiBjxUEEx1sIWIuaHynetwUY5HetOlcSBYSzhy4wgzV0CA
	6U2vG07395MHZU7oH4L3vsks8Qasv4q+ep+p3JA+GFfonv8Z/u+oaI/bl9QVgulmQVQjdIV8mLB
	VIDfWPS4eTpd4UAhKz/gwfSNLwjLDVNWhQ5ozYlItMP/c746INT0Y/UmgJ8nGjN4g9PYEK2BwmE
	JFMQ4Sqi7UB+gl4
X-Gm-Gg: AR+sD10eZFfU4/8vzxkbWc0R/+PNDjjQdyeKUl0eBpbFAswEEmMM4rsW9Jr6Fo2MMEN
	IVtZBxKoI4Tb36YRelh9HcfbZqn9OUt5lZKOVwjIvYmYDofPR2D9ZsaqolL6ba1oYCuhYySZK6t
	p7Zcy9068usQaS+HCQno7iLt++viNHNG3mg7y9+/sIEVEJV0Qf9wxsDIx2v87SzVuDFoK5hW+0j
	+TOvQid7z+/dGcMzR4bSc96VERoDg/kVy+Hcaw0k4btATnVZJ1/z60dLzwlrruIZ12lEM8ktdQ7
	4LJ6UxZiOmGF8dKxUzqTx3O2YIiAw0ht98pNV1velt3vJY1xe7EVrVbGxssgoPcTW24CKnoq3Hz
	8+4cHLF4/BuyGYBMiXw3U+NpHzE7u+qx4CMiuisE6vsKeha+q3A4dy0HfzKTTJX1g97wxav5/Re
	beJMchwlYnOYBnyLFW0qGIwXoz/XXppkGXZDOI7A==
X-Received: by 2002:a17:90b:4b92:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-3931e079c22mr788271a91.6.1786566260093;
        Wed, 12 Aug 2026 13:24:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3931efb831esm84720a91.0.2026.08.12.13.24.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2026 13:24:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so1749276a91.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786566258; x=1787171058; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZtZnEw9abfd2kfAccbrrChpAaOCNlD+RCF2EVqOizI=;
        b=G704KI8O1LtqDF/vHGXopyiqBVTlUVyHWxLhFmlPjkTRdg6jrr27d7T0NKxcuxQDVU
         FWXFQT1BbPnS7WWSjZQriebYTKkWxHo/+AdBxXGy69GXyG/IZE2Bb1SDP5vAfZlNtIrk
         ipcCJYdhzw6kE36f+c7+jdnbOJ5W2dBq0xx8o=
X-Forwarded-Encrypted: i=1; AHgh+RqArHOOYT8tw3HsxuOJHX6T4QMAGsXOzJnIfHhfEH6WyZ9xDQj53eH84oxQxnNiI9/Cy8G+dBA=@vger.kernel.org
X-Received: by 2002:a17:90b:254a:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-3931e2dd751mr874733a91.17.1786566258305;
        Wed, 12 Aug 2026 13:24:18 -0700 (PDT)
X-Received: by 2002:a17:90b:254a:b0:36b:77b9:5c8c with SMTP id 98e67ed59e1d1-3931e2dd751mr874693a91.17.1786566257764;
        Wed, 12 Aug 2026 13:24:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf628e2aasm16442300eec.14.2026.08.12.13.24.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 13:24:17 -0700 (PDT)
Message-ID: <bab70c3e-eea7-4a3a-9f7f-da90d0ae5fc3@broadcom.com>
Date: Wed, 12 Aug 2026 13:24:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: b53: fix error propagation from
 b53_fdb_dump()
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20260812201121.2012356-1-vladimir.oltean@nxp.com>
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
In-Reply-To: <20260812201121.2012356-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 8/12/26 13:11, Vladimir Oltean wrote:
> The blamed commit replaced "return ret" statements in b53_fdb_dump()
> with "break;" which jumps to the mutex_unlock() -> return 0 section.
> 
> This is notably problematic because it swallows errors from the
> b53_fdb_copy() -> cb() path, and this will result in FDB dump truncation
> when the netlink skb overflows - see commit 21b52fed928e ("net: dsa:
> sja1105: fix broken backpressure in .port_fdb_dump").
> 
> Let's go back to "return ret". We don't need to preinitialize "ret" with
> 0, because the "do {} while" block guarantees we cannot reach the end of
> the function without at least once calling b53_arl_search_wait(), which
> will have initialized ret to some valid value.
> 
> Fixes: f7eb4a1c0864 ("net: dsa: b53: serialize access to the ARL table")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

