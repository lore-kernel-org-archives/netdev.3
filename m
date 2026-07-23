Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D284772B0
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828171; cv=none; b=ucZrbm6D/fDMMbG25MMEY1kSQpTCs9HMKJjCL/DPrzObrMvIJmZtC8gX+wkXqyMU3AEyQSnRxoTgFNoIma41bVUHeCyKCAI4++2f1ZYOjVybc7vyHLisYOjTNGcPG2I/UPbiot+oEQq13bUtxX/ILnmjkstnc8uXTQHfBAZ+qUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828171; c=relaxed/simple;
	bh=FNfk+lFCMDHRrsPx2zYHsiBzeqQdmFDB2oFZU9vhHQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XHbVZiGgPKikLcHItyq7SXUOzfRU/Zt3ee68tfHdTr+mnnqxLTXBBlLnhNDL9FXPP/9Sc34EQKgi0JrocXFfwi9ab8I1/aEqYTPdLcT1u6ZgnwX14W4tQ45NbT6UbYNM8+QsXSUd5pme6tn80cwsbMgFcZ/FS/ZDz5lhELNq1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsVg8poc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsVg8poc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 439C81F000E9;
	Thu, 23 Jul 2026 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828168;
	bh=FNfk+lFCMDHRrsPx2zYHsiBzeqQdmFDB2oFZU9vhHQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HsVg8pocpqYnHQRV498crOvfqYB5otZatDFx1ZbBiBDRPJayWK/s1xQxMnlETGGpJ
	 YtZFvdX827Mlehemd5JPxdBllt/4vvfANclZLfUY87ztBB4f2+wjdWMW07LfZwYMRL
	 wz0TlCggskSoVl2n+ZzRf2u7/LlNni6H1YDlr5qQocSRVHDq7l2YZv2posfNVgQorZ
	 DuaVTTmVIsg0TzFDj9cbtq7PQCZk0j6YkcrsS/+fxWaqUGqY7D8uG2EN6CXLF9BqqD
	 xeE/LUaOglWflDGZ+y61QkG06f3qHGOYdNRQY5EbrN/2xKCooHgdWSAPN6HbRPjgzJ
	 kOvKZfpsZN2IA==
Date: Thu, 23 Jul 2026 10:36:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [TEST] google runner needs nested cases
Message-ID: <20260723103607.55debff2@kernel.org>
In-Reply-To: <CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
References: <20260721063829.7d9e6c7f@kernel.org>
	<CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 10:14:20 -0700 Sheena Mohan wrote:
> Thanks, Jakub. We plan to merge the changes to support nested arrays
> for sub-test results by next week.

SG, please ping again when you do, so I can check and close the request
on my side.
