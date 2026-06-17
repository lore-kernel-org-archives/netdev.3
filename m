Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE33B8413;
	Wed, 17 Jun 2026 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781732148; cv=none; b=gCJApUPhBK64F2WpGv3r14qmrIXN8PRLQC8zZBkXIt8mMmawDwhg6paPn1DpK7pgT0EkD+JcbomtlPJj9366NKhO6WqyquYk74+AY7i+AjV+q49n9/XazMMKLjKHSayw4DgW9qIckiknDwbdfKYgwRDkCDAK4m0fCrwam4lDCDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781732148; c=relaxed/simple;
	bh=4zM0t/NNS0aXX/L0toG6tdWJncYQSTlT23kpgauvtnY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXDH4tiSjbI61s4LLZK9w9lQ5QmF/NkqjvwPMt3qRI6I9KNCQxcWcWORQVCeI26fZLuF1cG5d3Y/dzlS+uuYgUtM+siVETF0S9d5z8pgFz9WNtz+nWdadAcPoj6CKIg9tG3KKatNTBoN1MDoEL4Ez1hlN0RBoT6pN6KQsiXuy6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYHJW721; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYHJW721"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F232A1F000E9;
	Wed, 17 Jun 2026 21:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781732146;
	bh=uRfXJNcthQCgAy/2/5C1RpLOF0v4wynixEcGeTRlwY4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gYHJW721aT41s7LJYe3ehqyMWZyVPIgaI7TMN1juAZlDCo8jWTa44Fzq5DtfuNF46
	 0p2UDcxYWtFekykg4boRkkWB0v3aIwsnXzFq+s0VP1vwXlOl9xA3tFgd1PoS2+HT1a
	 DT/m5QP+GcUcTNJcZ1gz5jZSHqFH7XDhAk/6aNymim6kcSX35x9vfJMKbsIm7RRg0W
	 Vh47OlW3MxdzcqORw3A/MDn8557x3N/YVq0CQMdqzzdqRe0DBcP8x/bbKB7yOlSN0C
	 jue5RbMxoVNMFDG5TYHRHeYqvy2NJ/3wJlR9r4mFcp1UFtUJ9AcDC1uT2z+iKbsoGD
	 DC67wR/MLxSTQ==
Date: Wed, 17 Jun 2026 14:35:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: <marcin.s.wojtas@gmail.com>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] net: mvneta_bm: add suspend/resume support to
 prevent crash after resume
Message-ID: <20260617143544.2310b7a6@kernel.org>
In-Reply-To: <20260616112540.4181231-1-yun.zhou@windriver.com>
References: <20260616112540.4181231-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 19:25:40 +0800 Yun Zhou wrote:
> Add a device_link (DL_FLAG_AUTOREMOVE_CONSUMER) in mvneta_probe to
> guarantee BM resumes before mvneta and suspends after mvneta.

You say "guarantee" but you pretty much ignore the failure to add it:

+				if (!device_link_add(&pdev->dev,
+						     &pp->bm_priv->pdev->dev,
+						     DL_FLAG_AUTOREMOVE_CONSUMER))
+					dev_warn(&pdev->dev,
+						 "failed to create device link to BM\n");
 			}

Why not handle this error properly ?
-- 
pw-bot: cr
