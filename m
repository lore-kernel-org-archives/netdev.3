Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436876;
	b=3rajCSzIGxY5uNLxi7hpeepyOqmiftVYn/pmSznlsMKBoyBcMoA6CDJ8xhpQ8MEzNzmH
	 0XIq6Qs9B/hQ5sLS6aPaxUEpJ6YoFmMDMGC05rBzwv5F0tsrWt7i72XxpLDykLeZXvoYz
	 6YTkVYK9BzLRnYM2uRDl8ecB3mi6/5LeFwxgBF5lwo8NMN1mK/6bNDe7fXDksuEsr8dSn
	 B9kNdXaPkWkHntvgy2LGxJFgQRuPHAQJ84yz7NW3h1I48he5w/AUjcDb8HLUaySLq5NaZ
	 7Onn+CJyDDdX2XklUhxud0H+g7IGq2SnSDvdaHNMKgoH6rfeYLa6xq91oYiYe6n4/JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436876;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=KjPWGZ6X8LI0nWH7eBTwaOpqqKITpEprmePla9/9J4Y=;
	b=iiwcYAafVWRjcrWJrhdgpZ2KPHJDqLhTUT6kgIdKJVTMRp8G753dcG9fqNWN6CjaNZvH
	 suWG7IS3exhtz15ZIz5MmpaXJ/SDh6zayNAIbQ/xoySscvSfCawp0MQbEPQEGEZMgb3fN
	 f39HQnaLtYNVAXoYiyHRvPk8uaNcGpVB8xwcVnlCWvhjGM91gidPvI8eUmqm1Pd+y9OrH
	 s57bv+ERSJDF5lmaibYlbE/S2I0+RnS6KIZvXf4BcoNtIECFskSxmr5QrpHHbxrGDf0JI
	 L0ZMf0vRSEmEzmkHXuPG/AAWfJ4SzNLI6sbpzqkcv2DjZUT8Gg1Ul/f8Q4d+DLVCkpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9BSCHj6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22B2606A31C;
	Wed, 11 Nov 2026 22:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D9BSCHj6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B3D1F00A05;
	Wed, 11 Nov 2026 22:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794436875;
	bh=KjPWGZ6X8LI0nWH7eBTwaOpqqKITpEprmePla9/9J4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=D9BSCHj6ygOt+zV5A9LFVhRKoVP+9idURa9MD/hNbbO7IOXVbS2r7TLtktOlaurDV
	 kRazBAykt2la0ESAw7xHOnXQyezTOSgh/PkILJgcilfKCcHrclZpyzjwdZ2XWAN+xM
	 scZHfkSabSVJO/adW54wJwYwmrp+N0+ac+aX4ndbY1LP1aDpZoDf+9VMjy5B4VqwCr
	 EqNCUww+RubaC9uqgf9yUbyX+E4IsRKZ3rQKLxftDgBDNPTFdndo3r+7ZpSZQprHvj
	 jhShirE046o9aopOoSMFxGy8hnEPE8oEpNqXW17GwLMLwBZsFYllc21lqgrY5QX7yb
	 jWdOmKnK0CBVg==
Subject: Re: [PATCH net-next v3 1/2] net: dsa: motorcomm: Report error when
 FDB fails to add
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 22:41:14 +0000
Message-ID: <179443687465.2199510.164035927002629092@kernel.org>
In-Reply-To: <20261109163117.1792478-2-mmyangfl@gmail.com>
References: <20261109163117.1792478-2-mmyangfl@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The code change is right, but the commit message gives a wrong
  reason for leaving out the Fixes: tag.
- [Medium] yt921x_fdb_add() in drivers/net/dsa/motorcomm/chip.c now
  treats only YT921X_FDB_RESULT_NOTFOUND (bit 14) as a failure of the…

--

net: dsa: motorcomm: Report error when FDB fails to add

This patch changes yt921x_fdb_add() to check the FDB result register
after the ADD operation finishes. If the hardware reports
YT921X_FDB_RESULT_NOTFOUND, the function now returns -ENOSPC instead of
success.

> Not carrying a fix tag: filling up 4096-entry table with static entries
> is just asking for trouble.

[Severity: Medium]
Is this reasoning accurate? Before this patch, a hardware ADD failure was
reported as success. DSA and the bridge then treated the entry as
offloaded even though the switch never installed it. That looks like it
dates back to 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm
YT921x").

Admin-added static FDB entries are not the only way to fill the table.
yt921x_dsa_port_mdb_add() goes through the same path, and every entry it
writes is YT921X_FDB_IO1_STATUS_STATIC:

yt921x_dsa_port_mdb_add()
    yt921x_fdb_join()
        yt921x_fdb_add()

Bridge IGMP/MLD snooping is enabled by default. It allows up to
BR_MULTICAST_DEFAULT_HASH_MAX MDB entries, and that limit is also 4096:

net/bridge/br_private.h:
#define BR_MULTICAST_DEFAULT_HASH_MAX 4096

Those MDB entries are offloaded via switchdev into port_mdb_add. So it
seems hosts on the LAN could fill the shared hardware table just by
sending group joins. The same table also holds unicast static FDB
entries and host entries.

Also, the ADD is issued without YT921X_FDB_OP_MODE_INDEX, so the
hardware places the entry by MAC+FID. If the table uses
limited-associativity hash buckets, could ADD fail before all 4096
entries are in use? This depends on the datasheet.

Should this carry:

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")

so that stable kernels pick it up? If not, could the commit message
describe the failure conditions more precisely, and mention that MDB
entries are affected as well as unicast FDB?

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 33e5fc127244d..a7a9a74393045 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -725,7 +725,13 @@ yt921x_fdb_add(struct yt921x_priv *priv, const unsigned char *addr, u16 vid,
>  	if (res)
>  		return res;
>  
> -	return yt921x_fdb_wait(priv, &val);
> +	res = yt921x_fdb_wait(priv, &val);
> +	if (res)
> +		return res;
> +	if (val & YT921X_FDB_RESULT_NOTFOUND)
> +		return -ENOSPC;
> +
> +	return 0;

[Severity: Medium]
What should happen when YT921X_FDB_RESULT_OVERWRITED is set here? The
result register defines it in chip.h next to NOTFOUND:

#define  YT921X_FDB_RESULT_NOTFOUND		BIT(14)
#define  YT921X_FDB_RESULT_OVERWRITED		BIT(13)

Nothing in the driver reads it.

yt921x_fdb_join() only calls yt921x_fdb_add() after yt921x_fdb_has() has
reported the {MAC, FID} key absent, with reg_lock held:

	res = yt921x_fdb_has(priv, addr, vid, &index);
	if (res)
		return res;
	if (index >= YT921X_FDB_NUM)
		return yt921x_fdb_add(priv, addr, vid, ports_mask);

So an overwrite here probably means some other entry in the same bucket
was replaced. The exception would be a dynamic entry for this key being
learned between the two operations.

If the hardware can evict an earlier static FDB or MDB entry this way,
this would return 0 while that entry silently disappears from the
switch. A later yt921x_fdb_leave() for it would then see NOTFOUND and
also return 0.

Could OVERWRITED mean a static entry was evicted? If it only ever means
a dynamic entry was replaced, a short comment saying why it is safe to
ignore might help.

>  }
>  
>  static int

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261109163117.1792478-1-mmyangfl%40gmail.com
