Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72089314B8F;
	Fri,  6 Mar 2026 01:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772760073; cv=none; b=hqLa8G6+H4DFlvhYNhv3XSclekWUSPmTr8KdDdpq5hu/E+SLtsEBKQv1HcqMqnnxxgnYaSdNy6h4tOcDWrv3BrlYH46jmKPcI3j1DpicFfSl+cBeEjEqvAVjER0eS2unTrVO6T2fCfOC8cXBYJr5LfAA85dZI+L5HjkEGuFOslA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772760073; c=relaxed/simple;
	bh=GWOizdCxZW2fKfcx6eHSwN5tLnYnZ3QiRxQ5aiT1WKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLrmLRj6RwEDuawPvs5dksGyOyJKzQAzsN0rkDFmEUALhmKAwqBUkLGDTwYzyyIGL/jaJqGK9w6dTejNO7sZsDgG0ueXT2kdyHAvz+mvDnG+e/6hOQpcYBpbCJg1iwMBtHbgpFQ/flAW2mICIp36FkQlmhb8C/nP0rOHnVYrsnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vimux.org; spf=none smtp.mailfrom=vimux.org; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vimux.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=vimux.org
X-QQ-mid: zesmtpsz2t1772760046t9db5bc17
X-QQ-Originating-IP: pm5foq4wI0s8Yg8T5nGQpXqP6Nkc4LvL+rJqYIeiDZk=
Received: from localhost.localdomain ( [119.167.27.18])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 09:20:44 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13677970291522765697
EX-QQ-RecipientCnt: 8
From: Jialu Xu <xujialu@vimux.org>
To: brgl@kernel.org
Cc: kees@kernel.org,
	krzk@kernel.org,
	linusw@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	xujialu@vimux.org
Subject: Re: [PATCH v2 0/3] Remove <linux/of_gpio.h>
Date: Fri,  6 Mar 2026 09:16:14 +0800
Message-ID: <64F9F751CE011929+20260306012002.2320584-2-xujialu@vimux.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAMRc=MfBqPP3W0nCvyM9hqmgZbX8SVSZ0DGrJwLdKoAK7gqgvA@mail.gmail.com>
References: <CAMRc=MfBqPP3W0nCvyM9hqmgZbX8SVSZ0DGrJwLdKoAK7gqgvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:vimux.org:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mdy4c2f802JI9hVt7a20YERk3SaxT4+c1XlzEnok1h7RjGzWYzZK+rDV
	g9kW9PC7YhhP9SP2EjznPOZmSJ+nxd5EBVJSwKqlU0mDOD//ZaTZLeZgx78gpg9EgDo2Ip7
	M0cZ7/ziFNiaLbnY41bSh9LTA33eHJBqAo+nD+FrpPvQCoIYbn8GsXAHse/huBmRCZj6DGU
	5kop8h4CL17IuPuLXSXxLzd9z1IBRmNbrzCDM+/MvVywN3xJo3sRKhMxf90BGLSmeKChL2j
	qgvy4W3E+RIzoRasJULpsIWlRSpMdyMwTjYfHxB3n91CsMPqvZGcqzgsGVKycGdbbF1/S+q
	75Nwhj0+XMZbsAs5/DcabVqSGjkOcNi7ZPdNTuuCWyI4iRIP6XdOqhC/zxTP97q/SI84rjg
	q6ktbApiWDPE/6mq6cZhCe+0QSq8BpZ+/HzXE1P5o0QDZ1DwW6Pe2O6EJrITjM7X3OrAzdu
	JBYfvRpsKnZhgnqm9YcRIrvDjHc1Kui0xpzcR7Hlnl8PYzyaOR268pHPYMj/W74mIiUJI9C
	SN1q+2dPrd7wbeRd50jOywUJS26t5lY01MoReEwhXgmQeClx6FZ9k13+T9Ku8IqLM2Gg9xk
	YfusrJ+lVjYlkqjOrzxfR9ud9mzY4qKvUHwjSBBGUCuTxarOa3aD1eDtzOeC/m2oOsvBlYa
	+ICZZuYX881oJS5Ymh36EzCe8tfQq88ZxU+m7I+7Zkcyh/hhicPe03DnCcpkahmWfVdrQOz
	fb7y1GK+X/Zx0Ud1MANqOc0c0lbsb8KedK0JvBgEVowwI3iVjVGzWbunf/4weNFcFxqd0mK
	jgl3smjVPja1mRJ+VCAn7Hi2EBK34TKe433CAFZiStQ7tcufQne4jTFpkEXTC2oHY+UC2Uy
	26gRzpPW44s+QtsgkHDefVOPejXFEOIMXvpbDW7xlpFjsQdImBldl1GsV/Sadfx8CeyXp0Q
	YKbATyRxvJZYPEmQMYzu8Cmuc
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

Sorry, I intended to use format-patch but forgot to add the v2 version
tag and signoff.

Jialu

