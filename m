Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35923C9EE6;
	Wed,  5 Aug 2026 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948751; cv=none; b=kSjRZ5WmygzzDueUwI+GVN8hxSZcs7/1DhMSxrppEuLyGV+/2Btw3n3NHQPGPXGEEMVu5WIuMLSeBvm9NUSxSMd/SvxWTghJmDXubenvbMbdKpESJ6qhED/gNP5JlFYrkpicus0ndsoLY6gydxvH95152dfUFySHvqcaZXpUjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948751; c=relaxed/simple;
	bh=SjWG/e9JsFftod5QMkfxOHYiaCQw949R+sQ6XRHUQKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcIO7+gc88IwTcnqvUFctRuBoC+g9jVwsLZ/aDSdFCE2l2pmLPUYbbufO2s6CkAFWw26zhYyk5FP7CekpaKSMh8TC0dBHqVcUmZs7I9/AJBVXyiLjhTe+oaJahHhTzXVU9jeAsvUuP5PDP88pwMeGi0dojcPo4C0a/pUyOtYllw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJp+3HC6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJp+3HC6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017F01F000E9;
	Wed,  5 Aug 2026 16:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948749;
	bh=VvKjb1Ht0TmVMC+kyNtnHRJCc6afvYyetizuH4/ckL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJp+3HC6rodfwrd0M9RlVhBofdFa3w1JeWyfBuixRncQIOWVuAlOb4IXz3H6X7EMu
	 LwzrrLCLXhaLyrSnbm2lJWfvb4/g+Bf8ApNChQ1w0P/Zxm7dMe0KVNSvMg9WRv8E9g
	 fXSrJ/TCd9cjTtu+Vcqzza18I1/c2xFh0Bbsfjet3eZ9gTMgYrLIYasBsd3Fu0igwX
	 bq2DVYV3zfy5peD6e94Wf5Wl2Y41VXSgvLa6fguJuu657jzuGYQZu1YTDMFHvzB29i
	 Yu/p2LDk/tU1TghbgO0ISUF/NwmUPQ1Cldw8r6CMHwAfx0ENtYKj6kuu2T6MWMafe1
	 0kN1aeKGGpQnA==
From: Simon Horman <horms@kernel.org>
To: shaojijie@huawei.com
Cc: Simon Horman <horms@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shenjian15@huawei.com,
	liuyonglong@huawei.com,
	chenhao418@huawei.com,
	yangshuaisong@h-partners.com,
	ningwei15@huawei.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
Date: Wed,  5 Aug 2026 17:52:14 +0100
Message-ID: <20260805165214.606778-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804130933.880552-2-shaojijie@huawei.com>
References: <20260804130933.880552-2-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804130933.880552-2-shaojijie@huawei.com?part=1
---
--- Patch [1]: [PATCH net-next 1/3] net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info() ---
commit ba3e282274aa0911fb278f48937385c06cc8f3a1
Author: Jian Shen <shenjian15@huawei.com>

net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()

This adds msg->desc = NULL after the kfree(msg->desc) at the end of
hclge_query_reg_info() in the hns3 PF error handling code, described as
avoiding a dangling pointer in a struct that the caller reuses.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> index dac051e798da2..7e124e2c718da 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> @@ -1592,6 +1592,7 @@ hclge_query_reg_info(struct hclge_dev *hdev,
>  	}
>  
>  	kfree(msg->desc);
> +	msg->desc = NULL;

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5]
Is the commit message description accurate here?  It says:

    In hclge_query_reg_info(), msg->desc is freed by kfree(), but the
    caller continues to use msg across loop iterations. Set msg->desc
    to NULL to avoid leaving a dangling pointer in the reused struct.

The only caller is hclge_query_reg_info_of_ssu(), and it re-initializes the
whole stack struct from the static template at the top of every iteration:

	for (i = 0; i < num; i++) {
		msg = hclge_ssu_reg_common_msg[i];
		...
		hclge_query_reg_info(hdev, &msg, loop_time, loop_para);
	}

None of the hclge_ssu_reg_common_msg[] entries initialize .desc, so msg.desc
is NULL again on each pass.

Even without that, hclge_query_reg_info() overwrites msg->desc before any
read of it:

	msg->desc = kzalloc(desc_len, GFP_KERNEL);
	if (!msg->desc) {
		...
		return;
	}

so the freed pointer is never dereferenced or freed a second time.

Would it be worth rewording the message to describe this as defensive
cleanup rather than a dangling pointer fix, so a stable backporter does not
read it as a use-after-free fix?  The patch correctly carries no Fixes: tag.
