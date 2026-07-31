Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299F03A59A3
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 09:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785490114; cv=none; b=Vin4iN3xU5Mkc4nkgwN53qf0BRaacEBYHIdldlXvo5A+eOWS7zApYS1QK+e6G0ykrd7IYFid2jvZ/J+L8BVAMFrWFrmUnpJr3ZW2dlytyyJ5QGl4oR8tKWfQHcwP9YVUXTEEv1zkibU8RdJp+XyCiBuGMZpXREIhJc4zOWoB7AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785490114; c=relaxed/simple;
	bh=B6lnZ6re4ipdXA2AsLr/Qk4kNG+C+7dDeQUVln/dK4s=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=n6KGYVlw4Wa2M8P7FkyeqeFPfMT8d3nDZ1qnEBNFdHaH2NoK7Z74v4wuU8fz1WJ+/ElsQ18T4M5BxqmOSj/NlxyHyV6EOryy5p0PfAAoFb7357wNGF/JAqnNWFT3fUUX+GpCP4mwhSzERHHDFCKbOSUA+PUjTqL+xCJFuk/y684=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:tivesync4t1785490055td5d56842
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [122.235.139.83])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 12865441474952582425
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
References: <20260731061837.12672-1-jiawenwu@trustnetic.com> <20260731061837.12672-3-jiawenwu@trustnetic.com> <amxjZX1eShpKD1V8@gmail.com>
In-Reply-To: <amxjZX1eShpKD1V8@gmail.com>
Subject: RE: [PATCH net-next v13 2/5] net: wangxun: add Tx timeout process
Date: Fri, 31 Jul 2026 17:27:34 +0800
Message-ID: <04f701dd20ce$d21842a0$7648c7e0$@trustnetic.com>
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
Thread-Index: AQGvKca1hNpLUk5TH4rh01kaL1lr8AIUgh3gArm6K/m2vNTJUA==
X-QQ-SENDSIZE: 520
Feedback-ID: tivesync:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MbJyXRLS/UlCjU0rGNkKowjhTASK0nRkea0x+URbOkkYLGq2QspTcspS
	Db0hxEFhlIzDRMFmuH+9y2cWWa4tC9Tf0QlhMfK8RWrYvIOksw5e7gTpDqO5JyMB6BVrDZt
	egCXrZtwNwWmgqfAm0W0aNTQJbNnvKy3s+ZZPO+CA+PAy66GDEExUbx354zOw1GIFZ2yrCE
	UTNiI0gEowaoYx2EJy7+BkNBTfO7A1L7CQ3KZPLxi+aSYgJ3pIB3zts4FVGwD9T/JEgiRef
	8iVEbt7qpnaonRhvbOuj3isSw4JUcNr/75RPK43o3gTmn85xXkoFPRL5jR0lBJzHsVyvFy4
	Ae+d+/aiiYE7N/bxQjEMHdUmnIbUIOnNXATqb3xonZD0Yy/37K+36SfRtJ876x2icEurNgi
	1G58Nq+V6/nehugl+irAIAg1KphD1TVd3B1ODx8337lXS1R07RwDlOFlWTKsR4/QJW2WfMn
	sdoUp1afB26xiNpM5GQyEdnxSAFkl16mDVS5F123pErduwKOIee+mKwWckoGUlYt7OhxhPW
	xAZtQELTMIKSHd9FmeQXeob0D9naa6K7p4pdisKBKRGTz1WzazpaUgEVH7pm2cYlkp4B/VG
	aXDEhXCe7q5NIcl17CMnU/27Y0VHJRFwyqT7RFKfyB5i8WONTwLCSMUIahM/QACQw+dxFvu
	5p6K9KKoJnWkFXMcJRvsVOl8uX60R/Yyp+1JdWGGsMELblHn2DBDazSYjsPmrH09FbcP62/
	ieDmwPhkKGqRxaEg/eR0h8Ig2xsPMnY+W0b7MOBIZrUHkQb81dQeMPOC6N22O3GwONHlxz6
	mva4uE7Ul5A4CXg/k7NXqg6FMuBdGxtUVKxX8O7gGciAJfKsUtcj8+RuMUKZPeaouBBP16c
	aMrCt2EayrrYvJtKY9v7912zJ+gNOj6Ft3bJ57D8hXdR+O8SO+6/RRc4Kbnv7g+4/MEXNoc
	g6VmyANVcQv8+Bnel5kZLbQiCvy0Xi+72tMWGH738glkTu+Dv755bp9s1wHJ9NQBSeNZm+P
	fJ9fpm3cCbZSc8zk3YS2A1WxqUsDDjgArJD9Y4t7fVsKTbvqxXMuK0F7T5CdByCNWlC9zyr
	qvVc0fzNR7EivZY4oIfYAjIKjwxUmbfOU/sRyENSWfTYXmH+vplWSYSVEtM2o5MdA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

On Fri, Jul 31, 2026 5:01 PM, Breno Leitao wrote:
> On Fri, Jul 31, 2026 at 02:18:34PM +0800, Jiawen Wu wrote:
> > @@ -1275,6 +1288,7 @@ enum wx_pf_flags {
> >  	WX_FLAG_NEED_DO_RESET,
> >  	WX_FLAG_RX_MERGE_ENABLED,
> >  	WX_FLAG_TXHEAD_WB_ENABLED,
> > +	WX_FLAG_NEED_PF_RESET,
> >  	WX_PF_FLAGS_NBITS               /* must be last */
> >  };
> 
> You need WX_FLAG_NEED_PF_RESET and also WX_FLAG_NEED_DO_RESET? isn't one
> of them enough?

Sorry I didn't notice flag WX_FLAG_NEED_DO_RESET introduced by VF driver here.
I'll fix to reuse it in the next version.

But I think 'wx_pf_flags' needs to be renamed to 'wx_flags', since VF is also used.

