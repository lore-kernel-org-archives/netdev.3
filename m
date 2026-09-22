Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D282352014
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790039514; cv=none; b=Tpvk83wFpBKff1UzzcABRxrmsKLD8ooDOpgk1DVBlgKgzjtddd0j8IkkY24cKxxRrpSQqHiCzj+6gJluJDnv+Fu0ZEmECdmVf03vp1Wwft9d/Dcv6RfGtm8slKhRn47dsjp1hTIxuIMN6LDifJoymHyJzMthDIRvypMPUUgODSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790039514; c=relaxed/simple;
	bh=9bjB25MOQagFpVfX302DzA5X/L5h/L0uEeezOZNPedc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HBfzy3+oy+EXS9zfRXsiWIEixGtGD4IdJ6unWYgLLCsBCLoBQg+7Zuucka4Qdcn2ifwi5u1l5Li0lID2eHLijUT/gvG3HmZtN3o6xficdMYMPx+VFiYL/I9YUj/kxDfylJTgb7BE5nVMXCTauIv8eCxy4zFLEGAXYTzCfHHMYWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IlmW25pN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IlmW25pN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16A11F000FF;
	Tue, 22 Sep 2026 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790039512;
	bh=idHBfo/ZzwBDVI5Y6lmvSxt6rvYWXc/yOihqDYogSnU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IlmW25pNykWjwaplv+7dbYTwpAL0QYvDaFChywmdB1dN0udetHmniaUSbPEKuRJsX
	 KcMV9YKkFqQPkf3/0+QgY+hrvnI4XgaKtxuN0eamtFJiFHqxrUqX4uvV1pJo+RkqSD
	 b4aVmksFIzuHhdSGvtKijYVEs/egWR5jFvfxzZzW+ZPi5WfocJ3/CegWSUoASvxDeT
	 dXwZQ4GAOyqEk8jH9uuVE2YbRMNA9R+eK3ALx4dVUkcKOyRZvCmfUhoMAqLP3I26GT
	 hUPLYhaTcl2VibmKMCa/66rqCxYh5ufnlUDkpe/BvlTksDvtgZZfmCZwGUgf5/nzhp
	 xFjtVUo8RnHTg==
Date: Mon, 21 Sep 2026 18:11:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Naman Gulati <namangulati@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 kuniyu@google.com, syzbot+f0661448aa9511ce744a@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: gro_cells: prevent enabling threaded NAPI on
 gro_cells
Message-ID: <20260921181152.36e86501@kernel.org>
In-Reply-To: <CAMP57yVWkD5rUXYQhqpdRYtiFWxggZ1yN6rnEzMDNYJSUVuMow@mail.gmail.com>
References: <20260918173413.3222413-1-namangulati@google.com>
	<20260919172817.7d8673ad@kernel.org>
	<CAMP57yVWkD5rUXYQhqpdRYtiFWxggZ1yN6rnEzMDNYJSUVuMow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 10:15:39 -0700 Naman Gulati wrote:
> Would it be better to piggy-back on this behavior and add something
> like this check in modify_napi_threaded:
> 
> list_for_each_entry(napi, &dev->napi_list, dev_list) {
>     if (napi_id_valid(napi->napi_id))
>         return netif_set_threaded(dev, val);
> }

Yes, this should work.
