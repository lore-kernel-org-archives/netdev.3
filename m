Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887873BE17E;
	Fri, 16 Oct 2026 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142351; cv=none; b=MDcynYq8obqf+PgdJI5q7xajApZ8SQql4QDS0QD9wWm7Uc79azuxsoAtyX46FszEQSIp5AiOQqIofDYIDv6IaiXF7kSlgDC7mf+JMbAbdZCt+dZwgtLfWoatFnmZvACEAhdPnEWBSKKw6+foHSpOjWwuofndoveqAOjRy/eUmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142351; c=relaxed/simple;
	bh=zvpmhm+BAUlfIVJ/6Kp9ShG7pA3G2q65FWBMzuTisWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n/LCmWw3iBoqsDKjVTyPE6ERM68qNS2UdTOhApacMNUNRFk5YWQIcR2TKUESW+JOq59j9w0fDU9OPj3eXaFC+Au0An9tlpxsMPAtQFRopHG8ww+J73KmhwfYwESb6/Z2zvnUYhmvElBvtlaEBYor4jCtOvcg+l69Ye6bSSyetOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7mT5XDP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7mT5XDP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179381F000C4;
	Fri, 16 Oct 2026 09:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792142349;
	bh=R4WIaVmgxMJzlsaERAlBqwLuDwVcuzfSzsQMDWtKV3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R7mT5XDP+2oPGJhvdpCOK/511QiGEeN7bLMU3Bip4mljZXwdc3HKRiTwWMfFBmVz2
	 9vtGszLeSkIP/MK3fmyTqmi9cKVNnR2QRVx9DbbTAMadPNqehqRznEwf6+9Sp+IJVg
	 MpWw6qZ6dXuE8EBoHojDeqR5oZ27QVLUq3W+KuTxMJxenDFAx0PqyETroc4qYnxmwA
	 GY1Xm+55yGbsADcEO4rubxIdYoEpU60CAaSyMnJV0Df1ApkkyJpak2t1mmfrr8EGdf
	 At5nB8yiKDM+y9VEX9Hd6sAZwMqyXD2lsDLGrDSAtQU9mws+pJVi3bRKbJjxqKely6
	 tbfGRUPorGlGw==
From: netdev-bot+sinfo@kernel.org
To: Zhi-Jun You <hujy652@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sujuan Chen <sujuan.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v5 0/5] net: ethernet: mtk_wed: misc fixes
Date: Fri, 16 Oct 2026 09:19:08 +0000
Message-ID: <179214234859.408196.13768026652794039093@kernel.org>
In-Reply-To: <20261016-wedfix-v5-0-8b02e78fd34f@gmail.com>
References: <20261016-wedfix-v5-0-8b02e78fd34f@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
