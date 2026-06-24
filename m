Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB216F27F;
	Wed, 24 Jun 2026 23:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782344134; cv=none; b=VBIBNF/U91vfgEbwtn8CwgCAWDjqyit8Y7P9mf61aloKP+J6Ja6ctJFSwg4qeq14OVdiynq+gPMHHGQt5DlJSytrvxZnS96EAodhund5aSl1BiuJ0arbqVKEqpuTeUz2+jNUZzoIKfDoiP0rR4hhScV5RLLUCaE0h+6Eu56ZSR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782344134; c=relaxed/simple;
	bh=JLmutQCxoo5wzH9sgIQ32+4GwLi13waZ3ElW5YR0dMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZziqi5KGwZCJepFbgfS5mX13VUTAKGwCYiMG5M2KdDymALeg6fKL8ZgF9vmJjTd3xc/RAKVdux6qDwJBbpLRI9MsIBVo+eboZuiuYRdHG2/TfMc9y0C/O8PY6dCSfWKWx87WfK10VmNPsiJiDxqSxIbF0I2euCr5QSV0hUR3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5cwixsg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5cwixsg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F30C1F000E9;
	Wed, 24 Jun 2026 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782344133;
	bh=JLmutQCxoo5wzH9sgIQ32+4GwLi13waZ3ElW5YR0dMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=F5cwixsgtLYdexl9DskEsNL0+nnUb59ozL9di74fEHG1wzoVHg0myhY66KtbT85SM
	 /zBo7TaDS8t1cjY6+fLxqGI/NlIaFuvMkSENRhLqmJmGvH0jlAXchMuULAkX1DSIsz
	 QuGO1a8ExUudqTOoyrdUXM4HRP7QgaR97CrGnEPsm7wu7HzWkVgY9bPoNeUY09iOfW
	 zQio73OS7lZi9h/Uw7Uj6zgFzJCHuSbRg9d78H4AKRFEzU2+2PBeL3W18QgS2z2avB
	 aDan7AE9d8bVRIjZyPGjUG6CYTW2vT5igx61z8cYNmX5lJCLSJdlH/0ZI4dVwb8UYV
	 xB/51UsAFPivA==
Date: Wed, 24 Jun 2026 16:35:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Wu. JackBB (GSM)" <JackBB_Wu@compal.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Johannes Berg <johannes@sipsolutions.net>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Wen-Zhi Huang <wen-zhi.huang@mediatek.com>, Shi-Wei
 Yeh <shi-wei.yeh@mediatek.com>, Minano Tseng <Minano.tseng@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [External Mail] [PATCH v2 1/7] net: wwan: t9xx: Add PCIe core
Message-ID: <20260624163531.2bae55dc@kernel.org>
In-Reply-To: <b02c0e1e9f0449f2b819197e4329373b@compal.com>
References: <20260610-t9xx_driver_v1-v2-0-c65addf23b3f@compal.com>
	<20260610-t9xx_driver_v1-v2-1-c65addf23b3f@compal.com>
	<b02c0e1e9f0449f2b819197e4329373b@compal.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jun 2026 09:15:17 +0000 Wu. JackBB (GSM) wrote:
> ================================================================================================================================================================
> This message may contain information which is private, privileged or confidential of Compal Electronics, Inc. If you are not the intended recipient of this message, please notify the sender and destroy/delete the message. Any review, retransmission, dissemination or other use of, or taking of any action in reliance upon this information, by persons or entities other than the intended recipient is prohibited.
> ================================================================================================================================================================

If you want to do anything upstream you have to get rid of this first.
