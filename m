Received: from nabal.armitage.org.uk (unknown [92.27.6.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AB13B3895
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.27.6.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789395748; cv=none; b=gdiuVwmV7MVAa7Pa+aygl0l2J0DwqN+4x/suRov9vJmDso5qIdLdMP6m9LsPWeRoOlqBGnq3qvnOwZ5MvUGWHzslM1xDMhufL2RV9++zRFXm11A4UkxpOBpSjOzU31EHqIdL0AdvXkJp1YS8y0oS57pkvFISpFOepnFdgXCXaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789395748; c=relaxed/simple;
	bh=6+ahFVZsDjQ9RCvwjhmsJnFTQFWqfIZzKrnbOGGThc0=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=o3m9Hi37Fb4WE15S3s1Qjfi5FqGB8FznU/MqjQUY+O5l0rKc1r1pYo5MZbhnHZNlQelUBMBHIEdJUEBA6Orbk2EkwGbk2qUtJJyujv607Dmy6YTp2IvITjmFiyt2A0c7Sk/H/mef6q95GzhokqE55y+JKyqa/9FNpNWkA3MTVmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk; spf=pass smtp.mailfrom=armitage.org.uk; dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b=YE8JDf1/; arc=none smtp.client-ip=92.27.6.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armitage.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=armitage.org.uk header.i=@armitage.org.uk header.b="YE8JDf1/"
Received: from localhost (nabal.armitage.org.uk [127.0.0.1])
	by nabal.armitage.org.uk (Postfix) with ESMTP id D26762E5E2E;
	Mon, 14 Sep 2026 15:22:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=armitage.org.uk;
	 h=mime-version:user-agent:content-transfer-encoding
	:content-type:content-type:date:date:from:from:subject:subject
	:message-id:received; s=20200110; t=1789395720; x=1790259721;
	 bh=6+ahFVZsDjQ9RCvwjhmsJnFTQFWqfIZzKrnbOGGThc0=; b=YE8JDf1/yx90
	ztf8ywmv1jJatVwg3kYBUcFEbgLmT/JHUAWjx4mcP14YJ9H93ZoWhjuSkz+aNMfQ
	61sqxjgNm+eGtXm3BUqTJV2IYqDypW36oIGYYAWhikUu09RHdVllw3TO8Hj0VLhX
	7fFOY70lfmf85Pj0TNtqVq/+fW3+4kw=
X-Virus-Scanned: amavisd-new at armitage.org.uk
Received: from zarepheth.armitage.org.uk (zarepheth.armitage.org.uk [IPv6:2001:470:69dd:35::124])
	by nabal.armitage.org.uk (Postfix) with ESMTPSA id 15EDC2E5A0E;
	Mon, 14 Sep 2026 15:22:00 +0100 (BST)
Message-ID: <49f5ad9f2a4c1f2178f64383b4f05c21106fce7b.camel@armitage.org.uk>
Subject: net: parsing IFLA_INET_CONF broken since 7.1 if NLA_F_NESTED not set
From: Quentin Armitage <quentin@armitage.org.uk>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org
Date: Mon, 14 Sep 2026 15:21:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properly" cha=
nged
inet_validate_link_af() to call nla_parse_nested() rather than
nla_for_each_nested() for IFLA_INET_CONF. A side effect of this change is t=
hat
the code now checks that NLA_F_NESTED is set for IFLA_INET_CONF, and reject=
s the
message if it is not, whereas previously there was no check for NLA_F_NESTE=
D
being set.

The consequence of this is that code which worked prior to Linux 7.1, albei=
t
erroneously not setting NLA_F_NESTED now fails.

In order to maintain backward compatibility, rather than calling
nla_parse_nested(), nla_parse_nested_deprecated() should be called, as it i=
s
earlier in the function.

FWIW the following patch makes the change.

commit 5f372809f2f07fe7ed5b91b4293945e8a7fd343b
Author: Quentin Armitage <quentin@armitage.org.uk>
Date:   Mon Sep 14 15:10:42 2026 +0100

    net: allow IFLA_INET_CONF messages when NLA_F_NESTED unset
   =20
    Commit fa8fca88714c - "ipv4: validate IPV4_DEVCONF attributes properly"
    added validation of IFLA_INET_CONF attributes, and in the process
    changed the call of nla_for_each_nested() to nla_parse_nested(). A
    side effect of this change is that the IFLA_INET_CONF option is now
    tested for NLA_F_NESTED being set, and fails if it is not. Prior to the
    commit there was no check of NLA_F_NESTED.
   =20
    Changing nla_parse_nested() to nla_parse_nested_decrecated() restores
    the previous functionality of not checking for NLA_F_NESTED, thereby
    allowing code that (incorrectly) doesn't set NLA_F_NESTED to continue t=
o
    work.
   =20
    Signed-off-by: Quentin Armitage <quentin@armitage.org.uk>

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index a90be57c63be..2bb7b1c7565e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2117,9 +2117,10 @@ static int inet_validate_link_af(const struct net_de=
vice
*dev,
 		return err;
=20
 	if (tb[IFLA_INET_CONF]) {
-		err =3D nla_parse_nested(nested_tb, IPV4_DEVCONF_MAX,
-				       tb[IFLA_INET_CONF], inet_devconf_policy,
-				       extack);
+		err =3D nla_parse_nested_deprecated(nested_tb, IPV4_DEVCONF_MAX,
+						  tb[IFLA_INET_CONF],
+						  inet_devconf_policy,
+						  extack);
=20
 		if (err < 0)
 			return err;
