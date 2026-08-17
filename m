Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBAD3BB112;
	Mon, 17 Aug 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786965230; cv=none; b=pa3cOSa4DI9A06uR5pojhSmSudtEQUlrTTOMCdYyiQhAf+mUc9SOdYHsoihrUqd4LT2ciByAOyXz+2z9EEVv00FNeiRi51GpqvNAgeSMNXYlZ6fslzmmaGM0AQ2Bb7c/xlKa24p/urmOjQjfbqar6igQxeH/VtLwI9WOY4nVOqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786965230; c=relaxed/simple;
	bh=5OWGFl21V9RSEovb01TSZ+iqJKacVvSf+AnktVRnIfE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=UFXXQMqc0mzDWSZkil3dWnI7YujeGyukRUAmkLHEiMIwiZNyJuvYStyij166vL6+j1tGJD31EwcipyOx9mPGEElg1CYmKWqjT3iLNEA4fPkMtFn0129I8W938oOjJop9UQO97fXBSwk1ic4KZ8PEqM29CMGicnzRRlC4JCwM/0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PV804qx/; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PV804qx/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1786965210; x=1787570010; i=markus.elfring@web.de;
	bh=gUnkfYclqtknfhgjiDTv5FQoT3LwqeiUQJbMvcgZOqg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PV804qx/XIGV3z0O1HHr5n70MZdNfXBL5ZdLFoWZDM8x1Unjjt9ouiTP4wnDIATR
	 MMBvppA/WbROPoO2r6UjS4BjnXMpLTOobKcQdCGqLnPFCp8fZNd36xuMxMcJ5fgCQ
	 U5Y42OD/6hzIqEaF/IYg8LdKG/HAW1rkaeMM2FYg5BJVoQHPwLwaWskICcze5yhoF
	 pwQLp9tctRM6vKMUp9efdWwbDzA7lwhz2A9Vknjt/uGgInqjrjXPdiPWG97PebUB2
	 2UpadYeVqhuIUJtMbWvSzOIf7Qb/BjYAt9XkKQF+5RKv8s1XDmRvDLsWx96MaV7Zi
	 51Ytb//aZp5lM49upQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mf3qK-1wSeCO0kzS-00ak71; Mon, 17
 Aug 2026 13:13:30 +0200
Message-ID: <11265d47-39c6-43cc-9115-022d464bc154@web.de>
Date: Mon, 17 Aug 2026 13:13:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xiong Weimin <xiongweimin@kylinos.cn>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jason Wang <jasowangio@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20260811022055.3465420-1-xiongweimin@kylinos.cn>
Subject: Re: [PATCH] virtio_net: roll back RSS state on control failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20260811022055.3465420-1-xiongweimin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u2F7T1aWt33OKU9emrR8XZ2J8XTkOEGTnkz/yq5HRfYeYv93WvV
 cCyKKp9EX0Y+9u+FZiZEwF7bo4IYQBj0ZQC9OUdIXm0Fzlvg/mEQ9sTpsAhqAYjeFDDW1h3
 t+bNFBPUKFvseIS4DPFIYaBWdcOikRzz0a2RjN06ljCsAhB9DyQ/Z9lXbfs+qTOImdn37in
 2F0toGg5sQZFsDwIOPV3Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VkHnXzI5HpE=;JzIyejyPdnPgSVCtwZ1qGfs3q0Y
 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
 clMBWJg==

=E2=80=A6
> Preserve the previous local state around RSS/hash control commands and
> restore it when the device update fails, while propagating the error to
> the caller.

How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2-rc7#n34


> v1 -> v2:
=E2=80=A6
> ---
>  drivers/net/virtio_net.c | 56 +++++++++++++++++++++++++++++----------
=E2=80=A6

Please move patch version descriptions behind the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2-rc7#n795

Regards,
Markus
