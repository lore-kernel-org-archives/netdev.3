Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B8DB332604
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776326850; cv=none; b=HZlwLRwhcOnMGxZTVltwVmOOqZ5ne7Xai5JoW929yrgQ5F4l4d/1UacIUwUNm5RaoKMAuT7n0OdP930FeM8tc4Xq5oiSNYWCSq3WMMzna+j8cdAY8prSU25MbQn0m8zYL9bC74fBlvhFQset8sPYEKBhe3aiiv1TVOeWBIhnHUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776326850; c=relaxed/simple;
	bh=LtTfUHEnwBxkkN85Hf8PkQOmmfE97daUPWCqJMAQZZs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=i3eB4j2gDkwqDzfmUvk7CDvmCheuzI7qu8JbqmZfLRSm8Ubb9QFWwDeVgvhooAiIgxJdY+mxLuVVo+uQ+Y3qzRMgesyApcIRbeIl0XizkptapSBSYuQ0atdLRqjeS5s8K9xkQJpNKoNHbLwdA+435CRvTy96BPFThKwx/VkKxG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qNcFzZpD; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qNcFzZpD"
Message-ID: <861b722f-6d5e-4f47-9d17-00a98fceb8cc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776326836; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=FYIeF8ld//Ci23/JH9WUGw6ZRNbtm41sbeGdFAHhNMk=;
	b=qNcFzZpDyaCTQBM1PnlrvMSq5DCSOLienyHv6+JAA5fJNb57K7PuwEbgSQ9CMdMYSZnmnX
	HGTa1gRve+2kl7Iuv/SO6rsDzCK+8msXRcWISLSWi89u+W9i2Q+1qfXqdw3GDUaEd2A5/B
	vDMfWjUGP1vpw2cyPSh9dwSQVmlpvOc=
Date: Thu, 16 Apr 2026 16:07:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qingfang Deng <qingfang.deng@linux.dev>
Subject: Re: [PATCHv3] selftests: Use ktap helpers for runner.sh
Reply-To: 20260225010833.11301-1-liuhangbin@gmail.com
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Brendan Jackman <jackmanb@google.com>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi, Hangbin

This patch broke selftests run with `make -C tools/testing/selftests` as 
make uses /bin/sh by default:

/bin/sh: 5: 
/home/qf/linux-next/tools/testing/selftests/kselftest/runner.sh: Bad 
substitution

Add `SHELL := /bin/bash` to the start of lib.mk to fix this.
