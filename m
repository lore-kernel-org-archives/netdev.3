Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35855309EE6;
	Tue, 14 Jul 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050287; cv=none; b=B/EENVBQTa/Un2OBywVibXyTeA2oz7guap+HWXkrHHaK0NbVsZu9O0FamjA8mQcCPTequvm6HZww/pB1bbkquWv0xOxexXw5/UGxsvMitF/7ZOxnbPETdL+Vx+tV2tTIR3PaWPIk04J7BCE34NBU8vn0y/hCR5cBn+YR103ZZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050287; c=relaxed/simple;
	bh=/RG4Pdq+Qi47eOuzbFBrUxAdeoOtammBEwNp4sbBCrk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BLKvAc7mAmNOH5S3ersUav7RcAdSAaan6/VMBgb7tZaeEcl+QpytZGGKyAUwCq0tFF68QUHlmGgXQJg61GsVgL7R64mWtbpmccN0Z8VIvwV5W5zVAoNNhnSbRVqFWSSAaxYxMU63phtxEEKueca1SBfuPft8p6lqrPvFioYxu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=devmHpj0; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="devmHpj0"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 46132415BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1784050279; bh=lyUJrLbuB+J9S30KkswYbmzGW1x5LtGuRpZs6pHPJlM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=devmHpj0or8l0YQ/5CFs9kF2bXq+fTr3nR2zYZmBlEFVPru4v3mpZw2Ko4xS2g5ev
	 R/KokNmIs8nwUfM+ZIMoRcH6/fddklEQhMugBlr2DGePMl7PqxZOZzLqRgWUcf2E0l
	 hR+vT/djNM/lVAl/drsDG7a1ZFfBVpX22ClFhFT6kDtW+ZggSmRzSlX+nCI98NVUiv
	 17gEysydd+lWLOYa9I2nda43fhusdNTEFSGHbmGHPBrWN13fncjpgNb+ZqXb2tbNC3
	 KiumTHy3/21I70M2z/riniJhsWvR575GEbLXgJew1nrnbGkMIfmohNHLTWLAuyxIgX
	 UQwQqloE4NpGg==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 46132415BB;
	Tue, 14 Jul 2026 17:31:19 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David 'equinox' Lamparter <equinox@diac24.net>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: document RFC6724 rule 5.5 implementation
In-Reply-To: <alZvBEPH86WqH56m@eidolon.nox.tf>
References: <20260714094030.136317-1-equinox@diac24.net>
 <20260714094030.136317-10-equinox@diac24.net>
 <87zeztg1ye.fsf@trenco.lwn.net> <alZvBEPH86WqH56m@eidolon.nox.tf>
Date: Tue, 14 Jul 2026 11:31:18 -0600
Message-ID: <878q7deavt.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David 'equinox' Lamparter <equinox@diac24.net> writes:

> On Tue, Jul 14, 2026 at 07:01:13AM -0600, Jonathan Corbet wrote:
>> David 'equinox' Lamparter <equinox@diac24.net> writes:
>> >  create mode 100644 Documentation/networking/ipv6-addrsel.rst
>>
>> You need to add this new document to the index.rst file or it won't be
>> part of the docs build...you should have seen a warning when you built
>> the docs.
>
> Indeed... I missed it between the other warnings.  Downside of doing
> clean runs without a sphinx cache, sigh.

*Sigh* ... one of these years we'll clean up all those warnings, and
have them actually stay cleaned...

>> > +====================================
>> > +IPv6 source address selection trivia
>> > +====================================
>> > +
>> > +
>> > +RFC6724 rule 5.5 support
>> > +------------------------
>>
>> Please stick with the section markup guidelines in
>> Documentation/doc-guide/sphinx.rst.
>
> Oh, you mean I shouldn't skip the "Chapter" level?
>
> Now that you mention it, maybe I should include the file from ipv6.rst,
> and remove the document title entirely - it looks quite weird in the TOC
> with the direct reference from index.rst.  (Or rather, I've made weird
> choices with the headings.)  Does that sound good to you?
>
> (Or, I could just put the entire text into ipv6.rst...)

I would take that latter approach myself.  But others may differ :)

>> > +RFC6724 rule 5.5 is a very short paragraph in a complex RFC that has turned
>> > +out quite tricky, but also immensely useful in multihoming scenarios.  For
>> > +reference, it says:
>> > +
>> > +::
>> 
>> You'll likely get more visually pleasing results if you just leave out
>> the "::" here; you don't need literal formatting.
>
> I did that because RFCs are historically shipped & cited monospaced, and
> that's direct from the RFC.  My tendency is to keep it this way for
> "established convention" reasons, but I don't care that much - does
> anyone have stronger feelings?

You're writing the document, it's up to you in the end.

(But if you keep it that way, you can end the previous paragraph with
"it says::" and drop the separate "::" line).

Thanks,

jon
