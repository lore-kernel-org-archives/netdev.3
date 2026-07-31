Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271053DB64A
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785491753; cv=none; b=IszyXxZleF9qZsaJEauad+qSxSXwlsMHxsRpZvKPyZsqofSB+McBh0CMAUWzD/62n3PNYk2Ul2HVA7usImxTOOH2BOy3XJjlNDysBU8z4VFbMJV9ywSKGQLN7vylIVCempjOA4N81pS3ZWyhASVEeoijcg1VEcihKHEbfaFWqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785491753; c=relaxed/simple;
	bh=AsOIUmBy9HF3ILMPFXG1NXAVzPffNyGO3+vQ8IyYHiU=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9gLbEiQXNUKdqVMp/CpmqNMhUZ+P79tPPf67uxl6GFTl1Ov0znURakMV395pSfB41oJ/3XC19gEjtetjsITxfE5HjqmueMe/TYz1arHwWWlGCJByyv4EouBXHZJvncYxx3Gl5QF4eNZMf0eGxtCZsV15o7unWynPYs+G9V9Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync1t1785491701t3ee9e442
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.139.83])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 7302125335014293527
To: "'Breno Leitao'" <leitao@debian.org>
Cc: <netdev@vger.kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Richard Cochran'" <richardcochran@gmail.com>,
	"'Russell King'" <linux@armlinux.org.uk>,
	"'Aleksandr Loktionov'" <aleksandr.loktionov@intel.com>,
	"'Jacob Keller'" <jacob.e.keller@intel.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Kees Cook'" <kees@kernel.org>,
	"'Rongguang Wei'" <weirongguang@kylinos.cn>,
	=?iso-8859-1?Q?'Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29'?= <u.kleine-koenig@baylibre.com>,
	"'Joe Damato'" <joe@dama.to>,
	"'Larysa Zaremba'" <larysa.zaremba@intel.com>,
	"'Chenguang Zhao'" <zhaochenguang@kylinos.cn>,
	"'Fabio Baltieri'" <fabio.baltieri@gmail.com>
References: <20260731061837.12672-1-jiawenwu@trustnetic.com> <20260731061837.12672-3-jiawenwu@trustnetic.com> <amxs3A1lC7ijwE8W@gmail.com>
In-Reply-To: <amxs3A1lC7ijwE8W@gmail.com>
Subject: RE: [PATCH net-next v13 2/5] net: wangxun: add Tx timeout process
Date: Fri, 31 Jul 2026 17:55:00 +0800
Message-ID: <04f801dd20d2$a6fc5a80$f4f50f80$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQGvKca1hNpLUk5TH4rh01kaL1lr8AIUgh3gAkP9jXS2wI1iMA==
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MdTuaOGnZwiPJyN4dChWjTbguWZ09y+JCfHC/72zSttXMmN6dLbgrvOc
	KLyN8Dh/rXQYDUSnhtPnqTE8IDJKlO1byMdKZEV+xVR70irWlj15EZQAH3DCXo4cI3yd4TR
	iwK81z3vsjW9dNF6CiRk+tw3byYedQJfyDrWlivNBhgnDOSpfspryU4nkj2yL9nAjW1U29j
	A37W+kfxjxHf0iYF3zhrlLp0D+RVFfxeBz6aCWNnS11aM71UMHOEQcvSkRIovQeel+j8oUD
	QAJV14a+bfqAbNUG8Gkab+j/NzhU7VUKMI+0GPeSHDcGVQmjW7oMnqjl+9TttG+81S34M+S
	HhUKT74fk4K1Knwi4QSI0NjPZ/4aXuhnJmusIjMME2l7FzFk5e0e1Xbvq/KfL+7HTdYcquY
	8lR8E/vVGAA9g/aluuVkM12ED2sW1NgYSHj+XsXd1dyeX9CPcB9URRvmUtKIupPCADUD6/G
	YPYNYgDl0ctFSFHJyG3Vy84Z8NzkozfstPyrOfcD67/W5FfenOJa91E05pmR2ZNOyMb/MLV
	eFShgu6tavqhHHC3zzHZHXENT00zpxmX/gGs14je3yoPemcb7U6x/N8QzPeRHDZEjQSilCd
	66K0xitkFnLP2GQVIJyZyn1xdBjBWfpSWZFoFI+XkcLlyrzTa6GLK4DfeZt+tvVxfAsN2tn
	o4IBpeo2GNKllxleH6/fc/ACVIhA3LrDTtMlOdwKqrtAmoKX/dgQsc21OJPIci/VYYJjwjA
	cdKpU4z4ktqqJxn8Gvv5bJeNja5D2pqqYhJu6vlGIW067mr+h1ANTFRBc9pT8fByua6jcSN
	4s8RxNZMde9BJk1jARoWjsWvZy+R5CO+KL8O199WzX7Ya7M/LYuDiUZ/TDIGHmpgokw8Zt6
	+VXvs4Tv5JZ39zUu+vyr8Luy7A6oQmTlwexF3AamdFngLCG/UWXrMeioQlVupcVL06jDswj
	HCktY5vZ9JZAGr3+31T0jAyVfv20EsuwRIKa068CEUMWznwglPLQWPUJMqKXku5NKuavu+4
	Cd+0hfm555hje2GJzl8HgUyv0u5x9fvNv04qL6PJdS09oBacK4emRcCEW7KtdifGckr+alV
	j8GiStOkLsW
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

On Fri, Jul 31, 2026 5:43 PM, Breno Leitao wrote:
> On Fri, Jul 31, 2026 at 02:18:34PM +0800, Jiawen Wu wrote:
> 
> > +	netdev->watchdog_timeo = 5 * HZ;
> 
> Is this needed?  netdev_watchdog_up() already does it, no?
> 
> 	void netdev_watchdog_up(struct net_device *dev)
> 	{
> 		if (!dev->netdev_ops->ndo_tx_timeout)
> 			return;
> 		if (dev->watchdog_timeo <= 0)
> 			dev->watchdog_timeo = 5*HZ;
> 

Right, I'll remove it.

