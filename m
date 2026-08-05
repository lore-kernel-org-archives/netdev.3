Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A83C8194;
	Wed,  5 Aug 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948759; cv=none; b=slNycfonZrssa9eRZmGtKAD4nRB1oR5DpAjP0oF61EatwpgT9bqacRh6qlhoEn89cPYKV5veCJDJ83MUm0iRWtbOU6LLa4FldhPd4ol8OCz1IJbgdTEpVY2Ns3o55Whxpm/cJx9mQMBIEDcdMdppXsFcw+KvYq5fzM5sYpGDAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948759; c=relaxed/simple;
	bh=4JEFjYhL0kchkl5WjQI/Ll0F2pcfE3hbIJh85azAxZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFQjySBeWmkJQyTIfLiZ+19RfkkzHmxS9clr5d1x7c4FfEvL4iHKrTOLMbGMPCNXr4XWn+XfrnfZohfnmAVhxq4z6wEXq4oQHJn3QBIRs7EA8K/yXBLmw1LqygEP8W6zapPw2hlfVCEpzd9j6lRZ5bRwQ5orZ2WYkVsQfR49LGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ez3BC1NT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ez3BC1NT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1621F000E9;
	Wed,  5 Aug 2026 16:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948755;
	bh=JziJVmM8RLxbOD762dm4Ciqqq+HAv5kKIdyBdoNkWts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ez3BC1NTgq1dF7TjpdkOkHOpoW4zPgkfch9xJQohVgR4QBn9eI5d+lmR0m0LoBl1n
	 XMuZoD2xclM+Hrt91tC+EgUzfZXR+mFdux96C8wVy6Ccnwkz7XxDb2WzF0dM3pOwPS
	 C3gOEyIhg51ojheDVnWxpjmC+WPZL3eyYCxrUEacCWAxDOiSfEKGjS4GEwplk2hvOi
	 Rnr1qwF1WByKAcecvc7Js/ZLk2tw3QuSJYyWPn/dP+XVNMgRg353I7tbAkMTpEBgz+
	 K0tzINbwKLlmUJVcjLdtzs9tdUKxUuqJrciNIvrKexILrUcuV7XJ5ZdjH8lxtIZ5gw
	 LdmEVInx6i2ew==
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
Subject: Re: [PATCH net-next 2/3] net: hns3: add missing const qualifier to hclge_log_error() reg parameter
Date: Wed,  5 Aug 2026 17:52:29 +0100
Message-ID: <20260805165229.606837-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804130933.880552-3-shaojijie@huawei.com>
References: <20260804130933.880552-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804130933.880552-2-shaojijie@huawei.com?part=2
---
--- Patch [2]: [PATCH net-next 2/3] net: hns3: add missing const qualifier to hclge_log_error() reg parameter ---
commit c77e6cbb6d302d584ade8cd89a76f4750fe00694
Author: Jijie Shao <shaojijie@huawei.com>

net: hns3: add missing const qualifier to hclge_log_error() reg parameter

This adds a const qualifier to the reg parameter of hclge_log_error() in
the hns3 PF error handling code. The parameter is only read inside the
function, so the change itself is a straightforward const-correctness
cleanup.

> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> index 7e124e2c718da..6093a60d257b1 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> @@ -1762,7 +1762,7 @@ static const struct hclge_hw_type_id hclge_hw_type_id_st[] = {
>  	},
>  };
>  
> -static void hclge_log_error(struct device *dev, char *reg,
> +static void hclge_log_error(struct device *dev, const char *reg,
>  			    const struct hclge_hw_error *err,
>  			    u32 err_sts, unsigned long *reset_requests)
>  {

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5]
This isn't a bug in the code, but is the justification in the changelog
accurate?  The commit message says:

    Callers pass const strings, causing a compiler warning about
    discarding the 'const' qualifier.

hclge_log_error() is static, and every call site is in hclge_err.c.  They
all pass a bare string literal, for example in hclge_handle_mpf_ras_error():

    hclge_log_error(dev, "IMP_TCM_ECC_INT_STS",
                    &hclge_imp_tcm_ecc_int[0], status,
                    &ae_dev->hw_err_reset_req);

and similarly for "SSU_ECC_MULTI_BIT_INT_0" and the remaining register
names down to "PPU_PF_ABNORMAL_INT_ST" in the MSI-X handlers.

In C a string literal has type char[N] rather than const char[N], so
passing one to a char *reg parameter does not discard a qualifier, and the
kernel build does not enable -Wwrite-strings.  None of the call sites pass
a value held in a const char * lvalue (such as
struct hclge_mod_reg_info::reg_name), which is the case that would produce
the described diagnostic.

Could the changelog be reworded to describe this as a const-correctness
cleanup instead of a build warning fix?  As written it suggests a broken
build and reads like a stable backport candidate.
