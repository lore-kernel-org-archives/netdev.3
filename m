Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55D83D669B;
	Thu,  6 Aug 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015621; cv=none; b=ihsoJu+l8Bom6P5p7hZFwofiRTkC7KO5VUovDa88r3t8whXeGyv0yCUpSnb0gB7xljLqv7ZH09mf+BZ5Gy67zsVq4EEYJ17UQJP3F9Xf915CAzio9ysceD+fcjzJhA4ynBc4SGBV1eByjaz313/fXup/DzUmFx2f32cWfo8eaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015621; c=relaxed/simple;
	bh=xCDz7o+TsH0fxkBtqxT8EVLU7+UOO6vjIdBLw+o2LiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlHfNtCjcWJe+a+zyk8riX70064TuPbJdBfLeRw0YA6YkgAMEWegTaFVTOFemqVIVqbbv73I83p0DY8S7C9OAyku8Hh29EunI/ycYQtWv/KO2c5m+a7IxoQL4sbdtFRE/6I7rZ33FEzER7WuMpK87HKMDoIwynxMgQDT7quUcrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CDkAvJOl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDkAvJOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF2A1F000E9;
	Thu,  6 Aug 2026 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015619;
	bh=8zNhb5HkyFKrT8LFPzCbwqmtmRXOMvXw0uwmCxy8sXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CDkAvJOl/trzFy/Zs44BEVlKBQq6MDIyRiIRJPelh1Gvq9+5c5eCZXBQp5JkyXM/+
	 +Zg15KInZYbBEJUt1hv81atCcKnQvGziYGQkfsUQSWc1QytLMJ/sFk7oN+w3Mt48K1
	 q84sGHd50PPP73Jl3j2ZPLvI3ZpiLseq1uYY0mrEmHV1L+LdTvyYY8w5Ki1ISEGeuT
	 vxddCP9dLvx+Mnqc9wtsNdDF9yfaDma3EcbQC0JfpTmoqVfi0KEPddCVp6H3qwKheT
	 7pqJA2XLtDR+fN02v5bJQVAMBv7aAyoA3TifNyBtWlDmHohsf5tbueEiVPFPApO/6U
	 2VX5IS/Z3g57g==
Date: Thu, 6 Aug 2026 12:26:55 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	yangshuaisong@h-partners.com, ningwei15@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: hns3: set msg->desc to NULL after
 kfree in hclge_query_reg_info()
Message-ID: <20260806112655.GA51943@horms.kernel.org>
References: <20260804130933.880552-2-shaojijie@huawei.com>
 <20260805165214.606778-1-horms@kernel.org>
 <241a437e-bffb-4454-b9cd-f067e673922a@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <241a437e-bffb-4454-b9cd-f067e673922a@huawei.com>

On Thu, Aug 06, 2026 at 03:32:23PM +0800, Jijie Shao wrote:
> 
> on 2026/8/6 0:52, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260804130933.880552-2-shaojijie@huawei.com?part=1
> > ---
> > --- Patch [1]: [PATCH net-next 1/3] net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info() ---
> > commit ba3e282274aa0911fb278f48937385c06cc8f3a1
> > Author: Jian Shen <shenjian15@huawei.com>
> > 
> > net: hns3: set msg->desc to NULL after kfree in hclge_query_reg_info()
> > 
> > This adds msg->desc = NULL after the kfree(msg->desc) at the end of
> > hclge_query_reg_info() in the hns3 PF error handling code, described as
> > avoiding a dangling pointer in a struct that the caller reuses.
> > 
> > > diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> > > index dac051e798da2..7e124e2c718da 100644
> > > --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> > > +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_err.c
> > > @@ -1592,6 +1592,7 @@ hclge_query_reg_info(struct hclge_dev *hdev,
> > >   	}
> > >   	kfree(msg->desc);
> > > +	msg->desc = NULL;
> > [Severity: Low]
> > [Finding: main-1-0]
> > [Sources: opus-5]
> > Is the commit message description accurate here?  It says:
> > 
> >      In hclge_query_reg_info(), msg->desc is freed by kfree(), but the
> >      caller continues to use msg across loop iterations. Set msg->desc
> >      to NULL to avoid leaving a dangling pointer in the reused struct.
> > 
> > The only caller is hclge_query_reg_info_of_ssu(), and it re-initializes the
> > whole stack struct from the static template at the top of every iteration:
> > 
> > 	for (i = 0; i < num; i++) {
> > 		msg = hclge_ssu_reg_common_msg[i];
> > 		...
> > 		hclge_query_reg_info(hdev, &msg, loop_time, loop_para);
> > 	}
> > 
> > None of the hclge_ssu_reg_common_msg[] entries initialize .desc, so msg.desc
> > is NULL again on each pass.
> > 
> > Even without that, hclge_query_reg_info() overwrites msg->desc before any
> > read of it:
> > 
> > 	msg->desc = kzalloc(desc_len, GFP_KERNEL);
> > 	if (!msg->desc) {
> > 		...
> > 		return;
> > 	}
> > 
> > so the freed pointer is never dereferenced or freed a second time.
> > 
> > Would it be worth rewording the message to describe this as defensive
> > cleanup rather than a dangling pointer fix, so a stable backporter does not
> > read it as a use-after-free fix?  The patch correctly carries no Fixes: tag.
> 
> Keeping the message. kfree'd pointer is factually dangling; the patch
> is defensive. No Fixes: tag already signals it's not a UAF fix.

Thanks, sorry for the noise on this one too.
I agree that in the context of hardening this change makes sense.

Reviewed-by: Simon Horman <horms@kernel.org>

