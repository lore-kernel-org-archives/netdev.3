Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D874A3D20;
	Mon, 12 Oct 2026 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819712; cv=none; b=cfzTHpGIjcn7iRT+p9WfkokVF0+IUTiP+1932TEgFo0tQVqR/6ZnTb4HpEWU3CRzzDg0lW4u2u2REWGkJ1qfbT6EZhlvPLvxLO4hmqVWSwivSZ0ZPPoFvIyd03liftjzO0u3nCzPSVa+Yy6aKxma0JS47w5yo1J+XbWhEqdd0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819712; c=relaxed/simple;
	bh=/R4rj72R6/b+FnXNe0GqrFiWBQUvYfke5/tz6T1QZYg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Km0NTmDX0IU8ryZXae5bWV2oombHs4aSDfW+1CMxEZV/zPgd42jCD/lWx9QK42gSyz5p1PNyNc3s5cKlj4IRRCbq07bVofe0lbQUrwjbu5d4hcGxIjXUz8B71xGv7xqogkGwFfl5F8QKROfqfPNL8950J8kXOXgxs5qrhJMselk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TNeIxByw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TNeIxByw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C01E1F0089E;
	Mon, 12 Oct 2026 15:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819711;
	bh=ITI+vc9E+8NnDyyiLVVjVGZ2Ww05idVQo2C14NgwAvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TNeIxByw7FXKgW0cKnv0x4s8XeVfEb1A/SeHNUZrkqiBUVN4xmn+k2Yux6/lJMMnC
	 aByfBbiTKo8PvoHJvQ8dpBAsHpTfhqYN1tR7X25v0w+7sxfPzb6if+VU68HyPPoR9e
	 LMXFlLBeYZcp3Zv45RwO1bv3iBdqktSNV+sYc2qpYgvAzPpCx3T7+6yJ+8ddFcgzQw
	 b8lYVZdrJqcVErt4Ue1Sc7KecewhFfoQkVIdzEw7wcnZjB2Lw9+fgj12WxEK/1WBbF
	 A/uB2YhHv8lMAt3hDPU/LKgPBloYb6+bfgRVl1VWMdmJpD3mLtrZW29Q5Lbc8CuHvx
	 Mw+640LVU56/w==
Subject: Re: [PATCH net-next 02/11] net: ethernet: qualcomm: ppe: Fix
 multicast queue config table index
From: netdev-bot+sashiko@kernel.org
To: jie.luo@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, quic_leiwei@quicinc.com, quic_suruchia@quicinc.com,
 quic_pavir@quicinc.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_kkumarcs@quicinc.com, quic_linchen@quicinc.com
Date: Mon, 12 Oct 2026 15:41:49 +0000
Message-ID: <179181970969.434549.5801202132735347195@kernel.org>
In-Reply-To: <20261008-qcom_ipq5424_ppe-v1-2-16caf43e44ee@oss.qualcomm.com>
References: <20261008-qcom_ipq5424_ppe-v1-2-16caf43e44ee@oss.qualcomm.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The fix leaves a mismatch between the multicast queue config
  table layout and the access width used in ppe_config_qm()…

--

net: ethernet: qualcomm: ppe: Fix multicast queue config table index

ppe_config_qm() used the absolute queue ID as the index into the multicast
queue configuration table. The table is indexed from 0 for the first
multicast queue. This patch subtracts PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES
so that multicast queues 256 and above map to the correct table entries.

> diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> index 125b73be92b13..8a553902ffad1 100644
> --- a/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> +++ b/drivers/net/ethernet/qualcomm/ppe/ppe_config.c
> @@ -1530,8 +1530,13 @@ static int ppe_config_qm(struct ppe_device *ppe_dev)
>  				if (ret)
>  					goto qm_config_fail;
>  			} else {
> +				/* The multicast queue table is indexed from 0 for
> +				 * the first multicast queue, which follows the
> +				 * unicast queues.
> +				 */
>  				reg = PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR +
> -				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC * queue_id;
> +				      PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC *
> +				      (queue_id - PPE_AC_UNICAST_QUEUE_CFG_TBL_ENTRIES);
>  
>  				ret = regmap_bulk_read(ppe_dev->regmap, reg,
>  						       multicast_queue_cfg,

[Severity: Medium]
Now that the index is correct, does the bulk access width still match the
table stride?

In ppe_config_qm(), the multicast buffer has 5 words while the unicast
buffer has 4:

    u32 reg, multicast_queue_cfg[5];
    u32 unicast_queue_cfg[4];

ARRAY_SIZE(multicast_queue_cfg) is passed to both regmap_bulk_read() and
regmap_bulk_write(). That is 20 bytes per entry.

In ppe_regs.h, however, the table is defined with a 16-byte stride:

    #define PPE_AC_MULTICAST_QUEUE_CFG_TBL_ADDR     0x84a000
    #define PPE_AC_MULTICAST_QUEUE_CFG_TBL_ENTRIES  44
    #define PPE_AC_MULTICAST_QUEUE_CFG_TBL_INC      0x10

The highest field defined there is PPE_AC_MULTICAST_QUEUE_CFG_W2_RESUME, in
word 2.

With the corrected index, each multicast read-modify-write covers word 0
of the next entry as well. For the last IPQ9574 multicast queue (queue
299, index 43), the 5th word is:

    0x84a000 + 0x10 * 43 = 0x84a2b0, plus 4 words = 0x84a2c0

That is one register past the end of the 44-entry table, which ends at
0x84a2bf. regmap does not reject this, because ppe_reg_table includes the
whole 0x800000-0x9fffff QM range.

The commit message says unrelated QM registers were being written. Could
a register outside the multicast table still be read and written back
here after this fix?

If the entry really is 4 words, should multicast_queue_cfg[] be [4]? Only
W0..W2 are used.

If the entry really is 5 words, the 0x10 stride would be wrong. In that
case, would multicast queues 257-299 still be configured at the wrong
addresses even with the new index?

The later IPQ5424 patches in the series reuse the same 5-word access and
the same 0x10 stride for multicast queues 256-283, so the same question
applies there.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-qcom_ipq5424_ppe-v1-0-16caf43e44ee%40oss.qualcomm.com
