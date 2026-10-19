Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811EA4D4874;
	Mon, 19 Oct 2026 13:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416569; cv=none; b=Nr/NTdzDJcJSM6F5BR94IBWtVlN9leMDdURcA3L4F557fLOQT0Gny3+2futu6dmKx5y5mfz6LBT/lYPc63PsVKPMYC6XWlCK4sAjhcmXazk48YuXuvDTpILp7KvlICquiE2uYInEZ1ASRdWaT3rnQ2E0axpbffxyrIHSxngacKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416569; c=relaxed/simple;
	bh=f6EkHzolGy8GYPjeII04sc8oTncaFwHLWXs9LkHKYfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CGuSRfINGAbSVXHujA0L2Jw+WnivHiwWA3YecySD86wScUku5Tg/8cr+E4Vh2wBz5dkytTSAyIi6nl89BAD72VUl8YFBOw3ZcYirW+k/ZsVazujFA2kAGrK7N8e38e+2Cw6v9Ro0DqO3VhJ3aN8Qa5GObh2G6EBCLULWmyQ3NA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lpKqY4nG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lpKqY4nG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D75F81F000C4;
	Mon, 19 Oct 2026 13:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416568;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpKqY4nGj1pH4NxB0JPSsdIM2tNwfKpvy653MwldbfqcuhMIwFJwAHE3ik3g7I0Tc
	 PxazNo8maZ6oviQ9BlrnkxKVtAOH+canefmKbHzmVR+ONDwxhOEp/CBrQVFtRCRCqa
	 DGyVEKR3u60DA9RVIaAmiEf2LBg+5Raw99ZCnnTiZDTGchQ6aDhx9qACP8bsRDmtyA
	 IaLxwb6obxgLI9Hg3ALdBEeOTNgSiJAHtD7aKLGwRdyFklLoabSWgzS9+BzgJWGxAk
	 M3FRw2RTEioYB90EqYXixAHHoTA+XluBPgWrVIYK3UeuwgHyxyH3hW4RocXPRSatTg
	 uzrBv1o0e/Y5A==
From: netdev-bot+sinfo@kernel.org
To: Haoran Wang <haoranwangsec@gmail.com>
Cc: Jian Shen <shenjian15@huawei.com>, Jijie Shao <shaojijie@huawei.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH] net: hns3: bound debugfs queue-name sprintf with scnprintf
Date: Mon, 19 Oct 2026 13:29:27 +0000
Message-ID: <179241656738.3290.10146532361082613051@kernel.org>
In-Reply-To: <179241616311.5916.9868151766207198451@whr>
References: <179241616311.5916.9868151766207198451@whr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
