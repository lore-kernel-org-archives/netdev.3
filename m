Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466720;
	b=Xg56X16pbW2WDylf0wBEGK4OgSO82mrXanGz77AhBz432NOZRrIsmmOm4EsnF++qPsIm
	 D6rKMVnPyTwlqLMNcrNsvTFeqwyO3l1ZybrOVzwIKFkPIclgTwxHdIfXdijkBhcsENNsH
	 FOiFUSbfcKyaN9U8XC7Ir8ZT3O4S9b/hNWE4OsnZtLcI47R530HnfIBwXlYORHc76pxPz
	 diN/NEt5XIOEF33aV77YPFJq+rYTYTM1Xgipv+sx1y0tNrcFH1FvJaq6/uztkPoJGMWBZ
	 24nUjq6mEY5Sus/1tT8Rzh3wC4u3IShxDGNn3ZJq4OAxQfcOIHOjbZTN7z6jmwqRukw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466720;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NhZw5C0rgTr1ocrkYwSUc6e3LyFxAcb0L8T4XPqRzaA=;
	b=v9NtLq6zmj0TFRhd8NUOocxcy/jayHJTZsbkbt9E5XKECbdzfRbdoxj9wB/0iy4HyAHV
	 Nj/eg2DOhalEbQNYKGpBiSIL5aY0CW4RzoswLS9SgQxj94IxTMMZ3OBN2bcVVA5KPWTJT
	 wgUKLM7SGgZLnUzXMvCz+WoZF8iWkCZ9J2Oql2Banc30/R8Lfdp7v1nlgwub/I3iPT20x
	 NjiQqAB3mnwWUkWm/zX/FQ/0a4XGkW349INFSWV4Wyll45CKzhPt4vXegYEewUNsDhTvo
	 b2duDYCDWIPa745owzz1e7cMxm6cEGTJD/IIVH42+hGszUJPbeU36Qkho5wGevJ5a5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="Bu9lv6/m";
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814DA606A31C;
	Thu, 12 Nov 2026 06:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814DA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Bu9lv6/m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Bu9lv6/mW8yAhvE9kApc//a8/aSllpXA+xPb8gAzQ66WyvVgo9pGOgOoV8AnbVdg7ahGUTE+PQ+uj
	 SHxq7H5ZK/SyjvF/sxthy01Ejw3hoAm4XU5a/9eXBQQNd7IhQBeRyamCR/iBMSxtGid+OxnC9vLV4W
	 0F/v9LCfP0L8ZaBY=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af5639c52f-baac4;
	Thu, 12 Nov 2026 14:58:36 +0800 (CST)
X-RM-TRANSID:2ee16af5639c52f-baac4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.net (unknown[223.64.115.200])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee76af5639bfa7-f63c4;
	Thu, 12 Nov 2026 14:58:35 +0800 (CST)
X-RM-TRANSID:2ee76af5639bfa7-f63c4
From: Wenbo Sun <sunwenbo@cmss.chinamobile.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sunwenbo@cmss.chinamobile.com,
	1342116488@qq.com
Subject: Re: [PATCH net] team: validate the length of U32 and S32 option data
Date: Thu, 12 Nov 2026 14:58:18 +0800
Message-Id: <20261112065818.87554-1-sunwenbo@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <avUUw4deZxrmGJO1@fedora>
References: <20261111085924.360720-1-sunwenbo@cmss.chinamobile.com> <avUUw4deZxrmGJO1@fedora>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi Hangbin,

Thanks for the review and good catch.

On Thu, Nov 12, 2026 at 01:22:11AM +0000, Hangbin Liu wrote:
> What if the data size larger than s32/u32? Should we check it with
>
>   if (nla_len(attr_data) != sizeof(s32))
>
> ?

Agreed -- checking exact length (!= sizeof(u32) for TEAM_OPTION_TYPE_U32
and != sizeof(s32) for TEAM_OPTION_TYPE_S32) is definitely cleaner and
safer.

While '<' prevents the out-of-bounds read, standard NLA_U32 and NLA_S32
attributes require an exact 4-byte payload (as tracked in nla_attr_len[]
in lib/nlattr.c). Since TEAM_ATTR_OPTION_DATA uses NLA_BINARY in
team_attr_option_nl_policy and TEAM_CMD_OPTIONS_SET skips strict
validation, checking only '<' would silently ignore trailing bytes on
oversized attributes (or read the upper 32 bits if an 8-byte integer were
sent on big-endian). Valid callers using nla_put_u32()/nla_put_s32()
always emit exact 4-byte attributes.

I will update both branches to use:

  if (nla_len(attr_data) != sizeof(u32))

and

  if (nla_len(attr_data) != sizeof(s32))

respectively, extend the test to cover oversized payloads as well, and
send a [PATCH net v2] after the 24-hour resend window.

Thanks,
Wenbo


