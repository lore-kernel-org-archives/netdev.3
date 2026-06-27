Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5A19E96D;
	Sat, 27 Jun 2026 01:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782522452; cv=none; b=BYLKB9oaViN/5xfR5IIl1+2enH6pmkEplUgmUGg19q6+JjM+AGHkEEH3+C5iDjLnz1DJgVAmVTs0afn5nBIyjkmcx5YEq4l8mYCeO6ls0tDvoa4tHC7Zg06kkVFFvwaKP0VqwuhLstg81yIYJxOjTBY8enZHW4kED+Yo23xhpoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782522452; c=relaxed/simple;
	bh=vpIvxoKQKFfhXA+X6SFekX2JrlijPsGH42zskx/uscQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju18I2td5oQ3/Ji96US+5SU448nLOWtVMRmfO2lqN2O+r+tLdobcKzXkhAWCoasrRI3fpAK6Fe1MEu0lj7KdhZsbDSqbcEoSXMTZMe1rm36lVQa7aQ4+g669jA8vmho5Xu473Cha9JKRYfNacUi8yiE2OD6UoCaUdtMXFtv+7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz3k8gLP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz3k8gLP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA971F000E9;
	Sat, 27 Jun 2026 01:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782522451;
	bh=BkGX+usI/fxfwPaRgM4lPTX8bSxwTJJ7MAR255BYggY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hz3k8gLP8rPJyrjt+nEFqBgSY1elMbl0fKWxaTMYraLF8+RtZ9mkQ8YDxDqtxHgAJ
	 IxrsmpbyaGgWwroXoLVI3bihMiX7F4aGUsBVWIuJc4tkAF1iWky7WUjVO3bYhiPFci
	 8sR4+2dFJAsbt2WRnQmyrF05mwo4NFQCxA63LB0dAFFnuFkpSn3dvLB61Py28PsnCU
	 fka3P1xnj5IMNvj/9iDYYBH2YxQAWTASRqBYySgG91TxWVVNQVOZNRDhLtTzsBGQgX
	 NB4eUR04x+kjSy674m/Oo0TTYnb4CPT9PNGYI9i0nTBih3Cs5ZD52sN/EXdcNscmPU
	 VU8cZGjt+K2Mw==
Date: Fri, 26 Jun 2026 18:07:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jianhao.xu@seu.edu.cn
Subject: Re: [PATCH net-next] caif: annotate phyinfo lookup under config
 lock
Message-ID: <20260626180730.42eb297b@kernel.org>
In-Reply-To: <20260626042440.2013499-1-runyu.xiao@seu.edu.cn>
References: <20260626042440.2013499-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 12:24:40 +0800 Runyu Xiao wrote:
> cfcnfg_get_phyinfo_rcu() is used by both RCU read-side paths and config
> update paths that hold cnfg->lock before adding or deleting entries from
> cnfg->phys. The helper walks the list with list_for_each_entry_rcu(),
> but does not tell lockdep about the config-lock-protected callers.
> 
> Pass lockdep_is_held(&cnfg->lock) to the iterator. RCU-reader callers
> remain valid, and CONFIG_PROVE_RCU_LIST can now see the non-RCU
> protection used by the add/delete paths.
> 
> This was found by our static analysis tool and then manually reviewed
> against the current tree. The dynamic triage evidence is a
> target-matched CONFIG_PROVE_RCU_LIST warning; the change is limited
> to documenting the existing protection contract.

This code was removed a couple of releases ago.
