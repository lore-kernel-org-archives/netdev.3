Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD96B3ACA7A;
	Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691293; cv=none; b=loSGCVF/4OlQx8eUfyhbT740OfTMYqrkVFJOqTo22n6k9eDMaRklnf2FAkHB94b9FapZURze+G9xZlbK1l5Ddybb0kR7Jqljurd6nyQZI8gOHgh7K5g0MrijqUBILRKC0w3cJ66p4S9K8E5LyVarxiDXRcFDXgY28Z/06OW5W+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691293; c=relaxed/simple;
	bh=8IuLowldQlM5vyWZuim0L4vboYvqDtLOcLj9YZir9p0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nREaCL/Z3naM6MDzBGea+i40e8jcxrp3OmIT/X75V4gPxNplApcFAXVQyxiOM+vWIhoNLbsUJiVhPR5VwtZuIWzs7lGaTFvuJSnkJYPJiSn6TEG5CRcmkyFxKZ/1i2zMIVkPD1pFN6pwobTQSGlu+lOtLgl4s0mAG8fnPGQEBUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDY+ARWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDY+ARWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1ECC2BCB8;
	Mon, 20 Apr 2026 13:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691293;
	bh=8IuLowldQlM5vyWZuim0L4vboYvqDtLOcLj9YZir9p0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aDY+ARWH1AAOTewzlMTOCw8oR3nNf6Y0BU8tpzfAckxv8UXMXT51gJf9cOJ4baJEW
	 VIIGei11nEIKd9hQNiom5ePem7feNRd3nyuUcqcq9zx5CEAv+w2ahWmKkf/s/1Os7R
	 afs/BS9PHcOHzMNwKKByNVvhCTdaDL+4W+AvccM4v4c/N9qFrd7yuhxcX/DZ3/7f96
	 eN8UCjh7J7UGnmRQA3vL9ctid3bZ7mKqH/CT23hWzNtGKVYQ3wX5VnmlQif9HheocF
	 ASclRseiBg391luF4YQ/8NftLJ/C09Q3DgavDBeQW8hBFYykgYIZrivn8R70ZClD9E
	 esxo73A+u4zcQ==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH 6.6.y] ice: Fix memory leak in ice_set_ringparam()
Date: Mon, 20 Apr 2026 09:21:15 -0400
Message-ID: <20260420-stable-reply-ice-ringparam-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417091753.4175-1-681739313@139.com>
References: <20260417091753.4175-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Apr 17, 2026, Rajani Kantha wrote:
> Backport of fe868b499d16 ("ice: Fix memory leak in
> ice_set_ringparam()") to 6.6.y.

Queued for 6.6, thanks.

--
Thanks,
Sasha
