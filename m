Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B8727874F
	for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781948876; cv=none; b=L30wa0E/xB4ehHmx0AxhgcJ9G3ZzDgrTFI9UawCEAR1LkEP4Tzt2V5n10RPvkFlEq9t6v1muO7FEhy17T92i3uuodFF/m7x8smwN6iH2r24WQpT+Lb65xjEMMT3Y3KDevon1BWFC3pL6MkpbdkanXt1NHhWN1DMbjQ2JbRExQus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781948876; c=relaxed/simple;
	bh=JROjnkSJB1U4ePqKZpqgur7TGgaHRduatsqZY6QLSXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef43eVKzriCbXe0LRvO8qVyDjD+PmwcaW8TcVsPg4s9FigaUjhqR0sYsZp483Zn5CszE9Qr9w3vjAk/wkwMSQkWeymAXE8hI2gpyyC0MbDTg42T1Vthq5JBS3K6Cu0aThWMUJh9rqlArEhUyCPWJoc+6pY0hul7DvWSTl65qCmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TFM5gac8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TFM5gac8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49249072f03so2607455e9.0
        for <netdev@vger.kernel.org>; Sat, 20 Jun 2026 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781948873; x=1782553673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSYbUXTd9Ngne4Xxtlx29c5BFb1lGxLtQTLGucvyu0A=;
        b=TFM5gac8+4/nFSGFsuIRgp0qMJADu8yVC/P86bf3yF66Kgv7gx3DBj0aXcio16fSjm
         QHdInK3tjJo+LngGnd+dbLyPYw5eRltT1cn6MaiGLE2qpUDHlvp5yWomb8eratdaYXUG
         F6zXhKY0hr7AgXITIul2oprC9onDZeRHIutd7xS9QbHuCZ8+/1Cf1UIz7wNF/Y5SoNj8
         xbKZr6U9jK8WFOETJS5jQKh6KkBc02YMrgnR5NbrjR8c7IMxjcTdvnQfNq0BdO46qSr2
         NnYEEy2TRWEsVl0jJ4UupulKtLcdAWjmowSqMhQPsZlRHrW7/GSZdyHxThjeQdzkwHjk
         uAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781948873; x=1782553673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FSYbUXTd9Ngne4Xxtlx29c5BFb1lGxLtQTLGucvyu0A=;
        b=V/pMpiv3VKaev0I/rvBKjgx0y8joGAQOG/M5avfWo52vsqUltZ6ihollEZywm4vQut
         xVf1nBKSyThUnlFy2YkUpGl093HbGPmdOq9YMpvkzsXv7IMa/cMB0v1t3TfeCfMmXWfQ
         RekphwfP6u8YfgWh9hOOyjxfr9kCI4pSjYMe5iTmRZazHT3aaZ8cJZrx3Ih860KpGeO2
         A2hqYkiBnnS04oXQlOo1tIWweIJoWimEBE82G7tkTCZGtP3ckqyF/JQ0rn1T/zUNeE3P
         gihUOCxM9rid5/aRpe1GeH8/MdScIO9pIzyBdYGCcORIMr2fS2fynjLz1sOsR7NgC8ll
         kOxg==
X-Forwarded-Encrypted: i=1; AFNElJ+UUu4w+0IV7jDEedZKLTOz73hy7hwOKeD5YJFF3FY+W7abkcf80udowSUGt3LCcjoCdMQW9uM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz0EfO9mRh3wzi5VlM7ff8qQhpz1g4KIZEulmLkYDIHNJcUjjp
	FS0WNVT7riLdGs9RAYPeQ5AJQqTZHawg9Em1WPFXdiDMocXYGIncMpPK
X-Gm-Gg: AfdE7cnoWlHyv+ya5+ZM0qe/3MsWfdhm9fQKkE9VgPvP0mx86Qocj407CSjZqegbbPA
	39h9AhOmptFy+/tB19fiHxanLTaff+8npeiL6rS2wRzdW+5Z4DR2ujJ3WG5U+LnUIhiI8TD9Dr2
	cbPgS3oBcX8ARf+Zj9ya5w6YD5ok1/Qy+dV0GNlZtntpPQHDkv0fIiSMXdvH8gIUGgTHSe7RkeI
	S4nC7usALqLgvrWUCxPOpmMV1T6mioxbXRBabRJO4Qh8lCyw7zdOIm/rottqmw2RmH4MRcxV+gC
	dVKkiMVeUQdi1v/fxiEl3tzmLYHq/U4OhH3C4dR72k3lbrLfF528oWzdcjMkGZJXgxKy+DThAC6
	dIxwOJlGnfhSHVvRZLcimbx/BOfLjOR/FR6c4MrYwzJstxCdJR0OTF7LKx9iNfAMgB/XwyARMbW
	cBK0V7q5GIzqGbIYGafFTdnpstnwZLas3s1SZUKjNjShLI78s9LAkp665VwqVH
X-Received: by 2002:a05:600c:8b42:b0:490:b724:5085 with SMTP id 5b1f17b1804b1-4923f5944eemr141374365e9.33.1781948872931;
        Sat, 20 Jun 2026 02:47:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49240f054e3sm125314975e9.2.2026.06.20.02.47.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 02:47:52 -0700 (PDT)
Date: Sat, 20 Jun 2026 10:47:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Taras Chornyi <taras.chornyi@plvision.eu>, netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Oleksandr Mazur
 <oleksandr.mazur@plvision.eu>, Andrii Savka <andrii.savka@plvision.eu>,
 Vadym Kochan <vadym.kochan@plvision.eu>, Volodymyr Mytnyk
 <volodymyr.mytnyk@plvision.eu>, linux-kernel@vger.kernel.org, Jianhao Xu
 <jianhao.xu@seu.edu.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: marvell: prestera: use unaligned accessors for
 DSA tag
Message-ID: <20260620104750.5270a11c@pumpkin>
In-Reply-To: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn>
References: <20260620093739.2164921-1-runyu.xiao@seu.edu.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 17:37:39 +0800
Runyu Xiao <runyu.xiao@seu.edu.cn> wrote:

> Prestera parses and builds its 16-byte DSA tag from an skb byte buffer.
> The current code casts the tag pointer to __be32 * and then reads or
> writes the four tag words through that typed pointer.
> 
> The tag pointer is derived from skb data, but that only identifies the
> protocol tag location inside the packet buffer. It does not make the tag
> a naturally aligned __be32 array. Use the unaligned big-endian helpers
> for both parsing and building the tag.
> 
> This issue was detected by our static analysis tool and confirmed by
> manual audit. The same access pattern was validated with UBSAN alignment
> instrumentation by keeping the original cast from a u8 DSA tag buffer to
> __be32 * and reading dsa_words[i] from a deliberately misaligned tag
> buffer. UBSAN reported misaligned-access loads of type '__be32' in
> prestera_dsa_parse().
> 
> The driver has the same source-level issue: the RX path parses bytes at
> skb->data - ETH_TLEN, and the TX path writes the tag at skb->data +
> 2 * ETH_ALEN. Those offsets identify the DSA tag bytes, but they do not
> establish a __be32 object or a 4-byte alignment guarantee for typed loads
> and stores.

Stop sending these 'fixes' unless you can do proper analysis.
skb data is guaranteed to be aligned so that these reads (and ones of
the IP/TCP/UDP headers) are aligned.

	David


> 
> Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---
>  .../ethernet/marvell/prestera/prestera_dsa.c  | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_dsa.c b/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
> index b7e89c0ca5c0..276f98cbd50e 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_dsa.c
> @@ -4,6 +4,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
> +#include <linux/unaligned.h>
>  #include <linux/string.h>
>  
>  #include "prestera_dsa.h"
> @@ -33,15 +34,14 @@
>  
>  int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
>  {
> -	__be32 *dsa_words = (__be32 *)dsa_buf;
>  	enum prestera_dsa_cmd cmd;
>  	u32 words[4];
>  	u32 field;
>  
> -	words[0] = ntohl(dsa_words[0]);
> -	words[1] = ntohl(dsa_words[1]);
> -	words[2] = ntohl(dsa_words[2]);
> -	words[3] = ntohl(dsa_words[3]);
> +	words[0] = get_unaligned_be32(dsa_buf);
> +	words[1] = get_unaligned_be32(dsa_buf + 4);
> +	words[2] = get_unaligned_be32(dsa_buf + 8);
> +	words[3] = get_unaligned_be32(dsa_buf + 12);
>  
>  	/* set the common parameters */
>  	cmd = (enum prestera_dsa_cmd)FIELD_GET(PRESTERA_DSA_W0_CMD, words[0]);
> @@ -82,7 +82,6 @@ int prestera_dsa_parse(struct prestera_dsa *dsa, const u8 *dsa_buf)
>  
>  int prestera_dsa_build(const struct prestera_dsa *dsa, u8 *dsa_buf)
>  {
> -	__be32 *dsa_words = (__be32 *)dsa_buf;
>  	u32 dev_num = dsa->hw_dev_num;
>  	u32 words[4] = { 0 };
>  
> @@ -98,10 +97,10 @@ int prestera_dsa_build(const struct prestera_dsa *dsa, u8 *dsa_buf)
>  	words[1] |= FIELD_PREP(PRESTERA_DSA_W1_EXT_BIT, 1);
>  	words[2] |= FIELD_PREP(PRESTERA_DSA_W2_EXT_BIT, 1);
>  
> -	dsa_words[0] = htonl(words[0]);
> -	dsa_words[1] = htonl(words[1]);
> -	dsa_words[2] = htonl(words[2]);
> -	dsa_words[3] = htonl(words[3]);
> +	put_unaligned_be32(words[0], dsa_buf);
> +	put_unaligned_be32(words[1], dsa_buf + 4);
> +	put_unaligned_be32(words[2], dsa_buf + 8);
> +	put_unaligned_be32(words[3], dsa_buf + 12);
>  
>  	return 0;
>  }

