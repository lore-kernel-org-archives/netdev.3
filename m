Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04224399F2;
	Mon, 21 Sep 2026 20:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790022206; cv=none; b=Mncmm/6dHtGKjvd5a732QguzpjZIRwOvtQGi00jAmWvD5v2iczFI/2TJ+CtUKeDKYQnUwja8BHSAD0psQMnPz6EhhNrqOAOaMOSGOW6IHZ/mkM3fo6trXfc3VyuwKRedtnadBKkmi5xsiuY/c6jrKcnpe0+2RwUcjoIVJd1ATXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790022206; c=relaxed/simple;
	bh=VYOTwb66gU+4oJxF+oncxRA9TZFHjb7Mvd0bybKM5ck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qzV+owtziXbXmwaF0YvUWolxYyuCC6d+o3LwXCf2ceyH1/iDnPBRVKWd/znixC6XZfA7kT+u2jtEyq9GPmYrTFZ7ylNTQ5HQBuKTBr4xRdBT2Yg2WjhSG03qn0XgTPGkonup6cqLn/UljsAdfLblSZkI6uk68W1MSQCdI7V3UME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkSvno16; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkSvno16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A411F000FF;
	Mon, 21 Sep 2026 20:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790022204;
	bh=EuIYaACFfYHQrqG9qgcFjCKehJqKFbN314wuAG+MnDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mkSvno16N/KbJGqH9JJZG3oUqniaYsWHOFiSd9ghPUELNVKurBiKi3yJDjkAbLoRD
	 xGKOhi//72HswvsfOg1UO9UzNxVoOgyxDGA09uczWblOpvKqhNwVzKtE4Nmg7q8Alq
	 oJJdF3xhwK2GNG/oiFS+mklEUQB4Nl9i5O362wvz7KzhGYn4cGHMJqhOvsAUxpmejw
	 dF2Pl8nHmPWHq0/TTbk0nJYkY3n5GTnap8fnt9gJoyy/8oIWJW5OMFDhmOMgDcUm9d
	 8muczurGCO4jezT8YoOO6RqoACBvBu+HF+ws0+K52hrf/oCE/kEx9EPpGJno1pMcOB
	 4xz92dZYnAW4Q==
Date: Mon, 21 Sep 2026 13:23:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei
 Yeh <shi-wei.yeh@mediatek.com>, "Minano Tseng" <Minano.tseng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, "Simon Horman"
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, "Yu. Robert (GSM)" <robert_yu@compal.com>,
 "Chang. Jeff (GSM)" <Jeff_Chang@compal.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [External Mail] Re: [PATCH v8 1/6] net: wwan: t9xx: Add PCIe
 core
Message-ID: <20260921132323.7e6f76d3@kernel.org>
In-Reply-To: <690e3d6d04ba47efba2b4cda7b18e42e@compal.com>
References: <20260914-t9xx_driver_v1-v8-0-5206c2e6bea0@compal.com>
	<20260914-t9xx_driver_v1-v8-1-5206c2e6bea0@compal.com>
	<20260919165434.08d026a8@kernel.org>
	<690e3d6d04ba47efba2b4cda7b18e42e@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 07:06:23 +0000 Wu. JackBB (GSM) wrote:
> Two questions on the prompts document.
> 
> Are the following hard requirements the series has to meet, or targets
> for the tool?

Targets for the LLM but also these are describing a high quality
submission in general.

>  - line 44: "Ideal patches are between 200 and 700 LoC (added +
>    removed, not counting context)."
>  - line 46: "Avoid series larger than 2.5k LoC. The first series is
>    usually larger, but must not exceed 4k LoC."
>  - lines 57-58: "Series 1 should aim to add the simplest possible
>    version of the driver which nonetheless can send and receive a
>    trivial (no offloads) packet."
>  - line 117: "Avoid the use of managed APIs (``devm_``, ``pcim_``)."
> 
> On the packet one: this series carries no netdev because an earlier
> review found the driver too large to submit at once, so the network
> functionality was split into follow-up series.

That's fine.

> The document also asks for no defensive checks (lines 119-120) and few
> code comments (line 124).  That runs against the direction of the AI review
> we have been getting, where both have been growing.  Is the current
> direction still fine?

The kernel coding guide has not changed, defensive checks are still
discouraged. If AI is suggesting checks that can't trigger just comment
on the review or add a comment / WARN to the code to mark the condition
as impossible.
