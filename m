Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D39219301
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781391441; cv=none; b=D8Mh/x8g/78vNnug2NOThbh6Omkiza6zJJhs1XVIyr3+UmGxuS+IHxj7uN92NM7II8swkjlbzdoU8ClLn2pi9oC0LkuLRjy3/1kSR5ImN0rKJ2Tu5KO6pQkkbejXqZdUvuGU2EAgRKk/QFofFTJQIF79HUzB4SEtubZZCBLpD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781391441; c=relaxed/simple;
	bh=ZFrvxwQnZ6pSdcHqsFJGQ60DddBRaBnujElRx5LYB4g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nbeu2MHPRAXzWWmKxTHu4x6Sp2kpBOxTSpJUNGJCBLCfhYSeDpUM6vW9X1k/xqRenkrBURC8FfdeDQQs+9AVOJN0u9uqm+OLnEflr25kQM28CPgqfijytQPzNDf17PWcWSUJTG3RYAv5+u/8VMQCFUidERze0Md8doBgtCNBPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grd/T65A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grd/T65A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5671F000E9;
	Sat, 13 Jun 2026 22:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781391439;
	bh=k24wh30JTuty/CwE/HxdRXkLcDa5Rfp2ggyOA5fwtKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=grd/T65A6KZl28AaqchhcyOjS9J4+UOgi9XRqbbjPHSfkF9aKJBpGdJgyVbDu1fXh
	 4IMM4NlYZs+acgxBt3eFNnJye/BZF+XNDVdGRglKkyx4kdXwe3daZb7XW8RfBEMeMu
	 5dsHHr4f/BMlytmxli7sVgXUJAjsuG1iYpAYqZwr11vN0zszhcwAfNpQWyEDOHEiKZ
	 3fsamc1o2Q6xJLy1sQvPDJoEbUdXlMt3o5qKjNRLWXAwde48TxWm29ePMq0f7vgSdh
	 OB+b2tjVR5a5Dq9hIvTQ1WbhsM4jkp4g2E6vn3qDqXrbXKZLzEoe/M0sdz7Ge4lF10
	 Xsd7O+Otcoz8g==
Date: Sat, 13 Jun 2026 15:57:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, bobbyeshleman@meta.com, dw@davidwei.uk,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] Extend netkit io_uring ZC selftests
Message-ID: <20260613155718.16bf3964@kernel.org>
In-Reply-To: <20260611082527.741674-1-daniel@iogearbox.net>
References: <20260611082527.741674-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 10:25:23 +0200 Daniel Borkmann wrote:
> Small follow-up to the HW net selftests, in particular to add a
> selftest showing that also large rx_buf_len for io_uring ZC is
> supported with netkit queue leasing.

needs a rebase vs the PSP series that landed yesterday
-- 
pw-bot: cr
