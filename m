Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BBE309EF9;
	Thu,  6 Aug 2026 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015274; cv=none; b=aGKtxDaMwaNOUc7ZoH/+nQygQXVqAhD5FsYjdrBPXj2xnwMcBrju6BV6E+zU70VUD89VhzoQqIqxZJEy++lH4x2+7IlgKFI1lrHE4CsihSB4Qv9cavvoFG6he4bJyXWv6IDyMs3eFBoraxrC7xTap3nJsdGBduB2YJW1k8tm1fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015274; c=relaxed/simple;
	bh=aogFWGRpfWoySBsBN3S5uc6QcvtLT023JBQX5MUPUuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XorfOp0GUgCJrxNb3aYt6FzPHxS4oAih+ozzq51vY02EutmNptYcgHYKpeTLegP8mrB68lhE4H2bGS+9kti/CyzaLeY9+O3E429mSIhdob/lKVw4Y3FCFWrpHvrI4umXZnnQG7kvEozbjNPIZqrEFEImLuLf5wDXynEaEJCh5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMCtXrmH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMCtXrmH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413D61F000E9;
	Thu,  6 Aug 2026 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015273;
	bh=ujNSlZYfmEaiWrY448NY8Wgx20S7GmFSlI/bWL0grVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TMCtXrmHUeh0UulNTtUT1R55EXB7nlf6yCXyREVIo6zEw2KLb4lINKaGsQWjVraaq
	 ZbVBYFz3ZzI19tUU7stq7+IU6ba0WjiS96QBUgeANsK3vwtnEGK3kZzuNuluiLXMw6
	 pLHIFJnz8ENm9+qyGNVFz+x3lTCnqu0pfX+pytkd57qoIv1/UG0h3sM7771cwe5AZt
	 0L56alTChh9rG6/hTUtsiYU5tNJEXY7HGHmFgPpNEBLiXnR1aXeWaajczo/xSEzRZk
	 RvbJqvlUGO5mdbyyM5+97S4b4CpAuZH7YA+RKOVme1kPvTcatyiatTjfp2ZnpYGaPY
	 f4vbFYCrBxVQA==
Date: Thu, 6 Aug 2026 12:21:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	yangshuaisong@h-partners.com, ningwei15@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] net: hns3: add missing const qualifier to
 hclge_log_error() reg parameter
Message-ID: <20260806112108.GZ51943@horms.kernel.org>
References: <20260804130933.880552-3-shaojijie@huawei.com>
 <20260805165229.606837-1-horms@kernel.org>
 <b632384f-7de3-4411-890f-3b4e148f0de1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b632384f-7de3-4411-890f-3b4e148f0de1@huawei.com>

On Thu, Aug 06, 2026 at 03:48:20PM +0800, Jijie Shao wrote:
> 
> on 2026/8/6 0:52, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804130933.880552-2-shaojijie@huawei.com?part=2
> > ---
> > --- Patch [2]: [PATCH net-next 2/3] net: hns3: add missing const qualifier to hclge_log_error() reg parameter ---
> > commit c77e6cbb6d302d584ade8cd89a76f4750fe00694
> > Author: Jijie Shao <shaojijie@huawei.com>
> > 
> > net: hns3: add missing const qualifier to hclge_log_error() reg parameter
> > 
> > This adds a const qualifier to the reg parameter of hclge_log_error() in
> > the hns3 PF error handling code. The parameter is only read inside the
> > function, so the change itself is a straightforward const-correctness
> > cleanup.
> > 
> > > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> > > index 7e124e2c718da..6093a60d257b1 100644
> > > --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> > > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> > > @@ -1762,7 +1762,7 @@ static const struct hclge_hw_type_id hclge_hw_type_id_st[] = {
> > >   	},
> > >   };
> > > -static void hclge_log_error(struct device *dev, char *reg,
> > > +static void hclge_log_error(struct device *dev, const char *reg,
> > >   			    const struct hclge_hw_error *err,
> > >   			    u32 err_sts, unsigned long *reset_requests)
> > >   {
> > [Severity: Low]
> > [Finding: main-1-0]
> > [Sources: opus-5]
> > This isn't a bug in the code, but is the justification in the changelog
> > accurate?  The commit message says:
> > 
> >      Callers pass const strings, causing a compiler warning about
> >      discarding the 'const' qualifier.
> > 
> > hclge_log_error() is static, and every call site is in hclge_err.c.  They
> > all pass a bare string literal, for example in hclge_handle_mpf_ras_error():
> > 
> >      hclge_log_error(dev, "IMP_TCM_ECC_INT_STS",
> >                      &hclge_imp_tcm_ecc_int[0], status,
> >                      &ae_dev->hw_err_reset_req);
> > 
> > and similarly for "SSU_ECC_MULTI_BIT_INT_0" and the remaining register
> > names down to "PPU_PF_ABNORMAL_INT_ST" in the MSI-X handlers.
> > 
> > In C a string literal has type char[N] rather than const char[N], so
> > passing one to a char *reg parameter does not discard a qualifier, and the
> > kernel build does not enable -Wwrite-strings.  None of the call sites pass
> > a value held in a const char * lvalue (such as
> > struct hclge_mod_reg_info::reg_name), which is the case that would produce
> > the described diagnostic.
> > 
> > Could the changelog be reworded to describe this as a const-correctness
> > cleanup instead of a build warning fix?  As written it suggests a broken
> > build and reads like a stable backport candidate.
> 
> The warning is real in our internal build, which enables
> -Wwrite-strings. Would it be acceptable to keep the commit message
> as-is, or should I reword it to const-correctness cleanup and note
> the internal build context in the changelog?
> 
> This series is cleanup, not bugfix — no Fixes: tags, not intended for stable.

Thanks, I agree with your analysis.
Sorry for the noise on this one.

Reviewed-by: Simon Horman <horms@kernel.org>

