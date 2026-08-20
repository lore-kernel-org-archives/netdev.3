Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B97037E5E5
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247183; cv=none; b=nHcRjcUdQL+0aaFWSQXala46NaHnc+ZQn8hk2RuhWRF/u3u5h+Sg3RxAIR/bh38/N7mBQoGBO+wA/mqFXWrqIR9E9NXtgpubZB+lC9RFfXqBeLCkNuZHuIpa3R3znfUATsh2E0PaJoOe5t9WkOuzxWNJbrZoE0hFDhiNnWm2aKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247183; c=relaxed/simple;
	bh=x43GrXnD0/M/2cIzFmsNearOXSyZmd5YVTsIBSN7fiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LG6xqpLlNe5EAOgt66sqneU0vhZQW55vzihJDKXjbotXF5DL6s0a2XSzT3p6+1eeeu+5Bk6XZz253ziSgmK5fuk+D4N0fLkT2C4gL6huMc2v3ZWMADuBQdmb4Xb9N4lP1fiFGeXRrzrgqNiYGgP4qGr67abLZ4QizZzdViE85Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kv/mhl25; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kv/mhl25"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84FF81F00A3A;
	Thu, 20 Aug 2026 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787247181;
	bh=x43GrXnD0/M/2cIzFmsNearOXSyZmd5YVTsIBSN7fiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kv/mhl25cDxWlvP6/Up7q9Vqb8h++GMNjSCpBTkd+aFE8/2Lqn2y4xtKNQgS+CIsI
	 HPCxegCj/Cx6SJyQO1V8eQRPUJ/pjCqXseNjavjdfbXuP1i8NQLpOC1z3axS7M+jjO
	 gLWCj3YdxPllUV8wcIRIQlU1JsszdZouMz62XENjvjKyoSEeFnxvsLehrlkYp9v2Js
	 3QCkBdqgsNIz/EtYCfXcFaK7Bfzhh1Apl/OW5yslDI0AS7vXce8uLEgMKpE3Jcu2ec
	 gnx1Jnlqf5fId1E0dp4LhbMMzZfd6nWaYQuq1qLQTFMzjwBYzagTS8lPEPd3gsE59j
	 CRiM3Sd4T/xHA==
Date: Thu, 20 Aug 2026 10:33:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Triet Hoang <triet.hoang.dev@gmail.com>, netdev@vger.kernel.org,
 donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH] tools: ynl: handle calloc failure in ynl_ntf_parse
Message-ID: <20260820103300.1afde188@kernel.org>
In-Reply-To: <aoVlM1Zr1xsb2TkY@fedora>
References: <20260818132739.469624-1-triet.hoang.dev@gmail.com>
	<aoVlM1Zr1xsb2TkY@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Aug 2026 16:11:31 +0800 Hangbin Liu wrote:
> I think your target tree is net-next, but it's close now. You can repost
> the patch with the net-next tag after it's reopened.

It's fine, please do not send process related feedback.
