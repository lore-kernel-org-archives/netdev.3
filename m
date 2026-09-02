Received: from mail.planestimations.com (mail.planestimations.com [45.92.8.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C076171B1
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 01:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.92.8.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400687; cv=none; b=AmHfuXeFOcn9PS3ZDuAAFtQwsiY5vXWdC6xKV1WrXSa8mfQC0RSbMJCKq1c4b5BqiWQlA+DepdT2hDzVNCO2ZovkdcZEznbVXcmYBENiJTY3dacZ6AZqv020QGKTqj7qB/gRO0b/mUKfXQ3cgLBp11+rA1UqLyajsgdW0x9WlSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400687; c=relaxed/simple;
	bh=iOHJgRUfp+IAbon5wvN0j6K07ZTvR43G7gNnnV1WXKY=;
	h=Message-ID:From:To:Subject:Date:MIME-Version:Content-Type; b=XGnY/yu3nETzpo9IoatzGdcVn82v7DrOPOKC4P6FxFLNdFa160/W2UIZqYXlt8bHz27IqgZp6cN6HEN+ZGSlOwR1IzUFzTI1Q7YrxXR4dgmqJTVSL0vUvRKtdOXGLnsj6/HBU+rcVzJIPkkgjC1Za88tQujA7HGzHSPYTaUOGyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com; spf=pass smtp.mailfrom=planestimations.com; dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b=ilY6VtjP; arc=none smtp.client-ip=45.92.8.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=planestimations.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=planestimations.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=planestimations.com header.i=@planestimations.com header.b="ilY6VtjP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=planestimations.com;
	s=202505; t=1788362522;
	bh=iOHJgRUfp+IAbon5wvN0j6K07ZTvR43G7gNnnV1WXKY=;
	h=From:To:Subject:Date:From;
	b=ilY6VtjP4ttKRrpHZji6jmVyEX4GlqQVoBjJfFdBE2HfdYHT5eqCSEL3BIFwaBH2y
	 YOyFedweC9g8aEM0pgNCLUOMLNMmGxrN92cFss4yYvfPxN/nUbYg9P/I8+vAmQcvnd
	 l7XRCBuWbApG4vzqv5cdspwN5NbLiQyqCGAldGsht9PE/4BPMzc51OdqDdEkzG5R8I
	 Htp7PJ0L5mAH6JyoKdnjiW27G5GLRjnYWsXQDOAG/D67u8cizCJNQHP7oBmmakHaNW
	 oDEqmXy/RWkMdFiD9/CONQquFDJ0au5U6mVaPv/3jlmwzz4fCo8Ida6HJoCpGLPJnK
	 kGCIf+MChyOPQ==
Received: from [127.0.0.1] (ec2-34-234-88-152.compute-1.amazonaws.com [34.234.88.152])
	by mail.planestimations.com (Postfix) with ESMTPSA id 4191B501D90
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 17:22:02 +0200 (CEST)
Message-ID: <31587773-4622-48b8-b41f-fdaeaff202b1@planestimations.com>
From: Jane Wells <janew@planestimations.com>
To: netdev@vger.kernel.org
Subject: Comprehensive Construction Trade Takeoff Support for Your Next
 Build
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 15:22:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hey,

Our team at Plan Estimating delivers comprehensive construction cost =
estimates across all CSI trades including roofing, MEP, structural work, =
and finishes.

We prepare clear construction takeoffs with well-structured =
trade summaries, and we can provide a sample for your assessment.

Would you be open for a quick conversation this week?

Best,

Jane Wells | Sales Representative
Plan Estimating

Click Here to =
Unsubscribe
