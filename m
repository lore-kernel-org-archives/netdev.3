Received: from aib29agb125.bom1.oracleemaildelivery.com (aib29agb125.bom1.oracleemaildelivery.com [192.29.172.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE93002DD
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 08:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.172.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462925; cv=none; b=GUncNTAbuVLWClpsJNNgMdKROENhP8iVEyeCLLbQEMufSvPo1YXmAx4RtjKQulUyLueenFEy0qz/T3mRCqx9U/ErC8006pPVDr+h38z6aAkZGNLrEDbynnGwJHlf5MWVN2fNZU9QoxkfZvmUQzUTlJsbSIW61ic+6r5DIuPkDlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462925; c=relaxed/simple;
	bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
	h=From:To:Subject:Date:Message-id:MIME-version:Content-type; b=uuQswho69CkqZ2+g/4koQbm8wa6ZuI1y+iWwxS1Rk75uluogSO6CKEunrh+bYjOo8Cxc7KkvdxM9BZEfNwWf0b2U4Yy5bpqNdOQG5rquoz7pxSOOVoqFQTwOKZLdPeAFKZsZHpLlAKLcp8T0HynOf4cyRMo5fTSTRGO1NXyS7Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b=DbL05BUQ; dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b=JTwYrOh5; arc=none smtp.client-ip=192.29.172.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=linknsell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bom1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linknsell.com header.i=@linknsell.com header.b="DbL05BUQ";
	dkim=pass (2048-bit key) header.d=bom1.rp.oracleemaildelivery.com header.i=@bom1.rp.oracleemaildelivery.com header.b="JTwYrOh5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=smtp.linknsell.com.20250508;
 d=linknsell.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=DbL05BUQ00DYHVvdS3NAO2UbOUeic2v+gNdPDLwgDRctvDMcH6+NCkePtuHq7jQ17gdqvQiDBY91
   Fs3UnH2KgKmUCrbHolOveTVvED7aGMzhhvjjG9AuRxNin7+PJq5MihofQDmbEKbk3MG2V4xVtc4e
   B/qHFiS/xCdSG0E4/U5vtnJCZqxtTAlxIk/aNDXXiA++1VBpr/6oakdAVR50lOdRNrAqqodC6yDa
   FrAYJBc1umKH5ZMOIsZfC2UaDDXIRx2OvVLYc3ksaDHza0zPceadRElvKJpA0QuvNwpfg4/KVbNK
   BMK1IdeTEj4apjMt92nVz6lzIXYHcfH9kyzJ9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-bom-20200207;
 d=bom1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=DOGNxOuGnChhZQLwlrQLOpL2pK7O5LofYIVDLE+YYWc=;
 b=JTwYrOh5b1w+hhcK7sv9Xr5U7RCLWuj0eEHFjZc5PyMssEOHkcANS6y9GChodSph9YeyqJ4OOQba
   nJ1ilXxcNWi0jQdwozRUh7sEG6R8MLw8e+vj5tK4T1bBV664sUnA+mLkrei+Mb0A+EfitbZnsE7H
   h9AUvA4fXyxmjC1oSGLforWe4DJgAVN94slRMDWh/3Tp2iAkPgIUFZtsoUBf1ItmpxbJY7iwLFP7
   RVw5bwWyo9kYUNegdGcIzaDdnEyrNJKCfheTscDXIn1Rpyam5gA2wJ/T6yqES+37RcuxOtngQzNp
   JGYOnVzx1RfjULebzpJgApdPc+x4V7Kv65XEYQ==
Received: by omta-ad1-fd2-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20260212 64bit (built Feb 12
 2026))
 with ESMTPS id <0TD200HTABYH2A70@omta-ad1-fd2-402-ap-mumbai-1.omtaad1.vcndpbom.oraclevcn.com> for
 netdev@vger.kernel.org; Mon, 06 Apr 2026 08:08:41 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Reply-to: jisunlee@gmilweb.com
From: Jisun Lee <NoReply@linknsell.com>
To: netdev@vger.kernel.org
Subject: I need your help
Date: 6 Apr 2026 09:08:38 +0100
Message-id: <20260406075048.E34E85A4B6BF1E5F@linknsell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain;	charset="utf-8"
Content-transfer-encoding: quoted-printable
Reporting-Meta:
 AAFZ4Qxoyrv5K+2lYPZC9Mh2LCb8XPU7SkRF9j5w46KRuwxTYk0FUeFx2TevgHPv
 TnL/HTAqCHykhcMUTrBDSnL6V6yQSjsidAk5YlWok2ZBn66oz5hWjOWwp+CRFg6O
 O8QgWAc+s0NGU2+q46KtYVxxvX1jqX1peqbRnm6DbdBoS3FIoLolJfgEclcFwLRh
 MuRwoh6RGxdVqLwWE7ap+n0olkMkiT2rPQPadcoRlxDAPOG9tMLlRfmT9fwDwP4e
 dPpvsH0md6V5aDub4BPrO4xnWiP3HkZJ5JMMggOIXHOcF48bsNPdJB1ZloJrpvlW
 1rlFZQY9iv2e+eFLcTDH8K4jq6HBshwwlz3BVoPh5NcuiLRj+9YqwChInSGCIc8j
 6qlc0TnE0Qy9mHItC9USK69yVhHOpg/BaJlJOIf2HQi9B9i6AQATbjIZua6pn13D
 djsATV8jgpD/F2tbRCdC1XfBcRrU/0LFLhwfKzfkWd9Vze3y8009WA==

Dear Beloved

My ex Husband Song Lee refuse to pay our divorce settlement
funds. =E2=80=8BI need your help to recover Assets from the bank for=20
healthcare and child support
=E2=80=8Bpurposes, diagnosed with (bladder cancer).

=E2=80=8BI need your advise and support

=E2=80=8BThank You
Jisun Lee
