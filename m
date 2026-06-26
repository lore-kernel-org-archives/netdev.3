Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8997D36EA8F
	for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 23:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782518360; cv=none; b=Jdz1MiVKBn/FgG1J4HOTUelBO5qRejhM07rVMXTmqJqxFI3vekxtkTav7SAfT/pUwxNLuegHtD+3Okf9MBpJnbJwatPsWvbK0Ga4+KUAz9mbn7ojKjghwv91vaTekrEC8DHBxQzb4K5mg9h+ooPTeAPiTO+Gde5WFWUBXHPSdqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782518360; c=relaxed/simple;
	bh=Gfd485bhR5fKvi/LzOB3NX22vOSmLFU7qv2mJImeU/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GYPisNJ4uBa1bZm66akd+PHgHZNWgwld5RJ3XXBtbHrbG37VSh8+EfdXrYl7n8IlR7WcyfmBxs7AyF7rSUbwLUoeqOCltWWwDzMt9IYjyQfQAiuGMnNmbmNKq8WgR7OoeEWed1tzODLQnbHisIwIth+i+dvTGCv0ANewkoL97jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JRtSHPTL; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JRtSHPTL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782518357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gfd485bhR5fKvi/LzOB3NX22vOSmLFU7qv2mJImeU/Y=;
	b=JRtSHPTL/ayleQUHEeFKDkG7IZcfvOz0cJME993edNVisaN7rsgrn5k8kKQ7d4PT76+F7J
	F1fdCpwM2lZEM2+2zEinvTINgi7irVmX+XnzsV75wP5bwUSmueCTLhGc5offBieLR2YF/X
	9Qbtp2uSk8IeDV4na4b2hhMY5VSHo9g=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org,  netdev@vger.kernel.org,
  alexei.starovoitov@gmail.com,  andrii@kernel.org,  daniel@iogearbox.net,
  eddyz87@gmail.com,  memxor@gmail.com,  martin.lau@kernel.org,
  shakeel.butt@linux.dev,  kuniyu@google.com,  kerneljasonxing@gmail.com,
  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 00/15] bpf: A common way to attach
 struct_ops to a cgroup
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com> (Amery Hung's
	message of "Tue, 23 Jun 2026 10:49:48 -0700")
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Date: Fri, 26 Jun 2026 16:59:02 -0700
Message-ID: <87pl1cdfax.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Amery Hung <ameryhung@gmail.com> writes:

> Hi,
>
> I am continuing Martin's work to support attaching struct_ops to
> cgroup.

Awesome, thank you for working on this!

I'm going to rebase bpf oom work on top of this patchset and will give
it some additional testing.

Thanks!
