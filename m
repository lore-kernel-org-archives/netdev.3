Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B104226A1C4
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028971; cv=none; b=i1VwomKBmfBf2u/7b2gsTxa9YsQik00FVq2utGx1pbwtXPmn6gnK4Fvng+NflB6CST4NQS8TGSgARW9gLidrl5phfl8qhxNiPdoA/eIValv1wz8N2cUWKkN0fEc0BIT8l++d8syGCbswymRQFiGICZ+5gLhO8tc9hBapkfKL6JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028971; c=relaxed/simple;
	bh=WjpWEr5FOgoZq1Ba/FrKVd0MZ5FuRK09IiML5GDEFYI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=U/b1yI+qp0F6B5bdZ7sjwye6/8x9C43n2RrIB/rbon/vGQWgCyVxfonJT5qbmH9a+wVO32UfUIztVo65i+gdNz4N4Yn1IZO3Ap7pRBpOEXAvSIcOJ/J6kv/i3Eu4H0+mcNgLlUySIeoS/202pFpZ0q+aD3B/yB+TFfjWGLZY/uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2qOph6i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2qOph6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30464C2BCB0
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776028971;
	bh=WjpWEr5FOgoZq1Ba/FrKVd0MZ5FuRK09IiML5GDEFYI=;
	h=Date:From:To:Subject:From;
	b=K2qOph6ittY/6YBN6yx/uEbS7EmorTR10irwrWIQF6xX5P8icH+LLVDNTqETU/cW6
	 piioQ+Ic8MNR+36znO1ETGrLaOjdkFMYO3CdaiVz57c2gzv52+m/dfVOo10kq/py/0
	 5z62KF3+fWSVWqVFBnaXXWWonvCMMhMIomWeNK5VF9DQTbA2o8orEGfuilUsg6/czI
	 KpD68UBhkBvhSIG1tfsfSs7tSFQKJEwyxoRpJWENed/+7ZwojvuFq36VVKUQXTdOVa
	 he7kQe4tcXwj3dYxI6wf1JTmDyXbjSzDEProhU3yfaAZtoXcF/KZufNmw0DoN4JdGw
	 wIaPN1dl4s6Cg==
Date: Sun, 12 Apr 2026 14:22:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20260412142250.131bf997@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged final v7.0 so net-next is closed. We will look thru
what's one the list, new net-next postings have to wait until Apr 27th.
