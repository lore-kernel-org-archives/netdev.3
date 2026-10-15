Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E8F2931D2
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792032104; cv=none; b=NfnrQQE+nhl5NpuWsk39jWWsdSByKyhbyOLAb95B1qRkWCqOhoZtAETtejS+0DTcplkv4RIqZBtqa/bZQvCHB9aCv7vdJecsXQW1p3IFc1sD7gfxpZqQsAd00wI7+nfUC572Cx4xp4ieRI2XbMW3lOmheP4aeW+W2uPk+Bhe6Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792032104; c=relaxed/simple;
	bh=xSLrUSKKZAPp2wcKpWJETkYozmlfLo3zMRG7G4pGckw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myM5OibXGDy2aI5gFrRi53ZpRvLkrnQLGHqr5UlsHRNPb/Bu3RnkL35hPLI5CP3iQj4Tg7AViKhDM2pn5fj+qNHs4hKUjNBJkbOus5Ts4rXD0Y2Br5cH1URmSZzTP/LELNUuAK87CiMFr8TOfGV/IjwKqR3FCuM9tfKCO0q7LdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/X+n6g4; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/X+n6g4"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6cfed5dd071so3509545eaf.0
        for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 19:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792032102; x=1792636902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHkf0Mpwwazr30dqJ1ae4B7rfoUGvwnjCOldZ2sPi3k=;
        b=W/X+n6g4MWBynYAPwlgnchvwJ5T7e52xDljsfiBPZDw7OEevaX+a4dl+T4lj0VbRzr
         /TWCWojHgfTx1oYgBHS+8AEznKUqSzqJIcq6jXsj9Q0smhRYRi/Yyl9RUjB18BA60qG5
         wnGd8aN6Ayx4fd/1z9UEdR9ryRuYCC2PnjIXQSJ+kYtO4+WJj4xPoU3WCJXatBAv2lLO
         peitI/zE2xCuSKRYwkd7jwYJVXJ5auLsa42mneUiKxrhhhM+URHafgevlL4wVGytFF1j
         6M3rSDf7KhuBR/KjbERgUb+BTxixHeXx48rjcV2am5bp/g8hv49XUJ9xWmt+nQ+jWxVR
         vFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792032102; x=1792636902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHkf0Mpwwazr30dqJ1ae4B7rfoUGvwnjCOldZ2sPi3k=;
        b=iExuBQnvfvJ+7T3412Ez/SnoFoHPjdD9eavd+dDqDdSZPCA/MLgD5yM3aQjxc1wbsU
         zVysoXqtQkvUgzFxjGrj+iaa+tpN7QeSkwL7dr6EGPogB5BfH270wdOyfojKygzU+sdv
         MtVF+pWYtFrZMAaGnWBTIsF4Pvn+Rp2JpkdsIUWfrAhGPvdjwRE3CQe6YiAalIHOr4Ai
         P0F6SEfOcEQ3IDizGfY0V8FA7p11y3jMc3ooR7h4Mvm5zNMjHKlWRAHgZAYL/eY+EPUR
         ryN3bRClbQUJ35g0emthfbhuMvbFUFmYAkJWI77XYGDpD+ko7lvyrER6hyQhv1V2rtZ0
         0esA==
X-Gm-Message-State: AFq9FYJ3X3U46ZX1oSflOCX4dGSKOdXPjDO8HzJP3nda7ZIcRNIbO1Ez
	TWGZ4UJSYq2t+n4P44WF7/pmZ6uJBRbMbrAlaNfQ0yyx7W4POCBw7WIb3nTqZRMZ1zgWtw==
X-Gm-Gg: AYBFou0CJRqGXrSxtDEVcbHuu7gEsuo02kwN4cECtpJnGB/3r30Ou34e7dWqTDTMmfR
	I3GgYbsx94Pyak2171xCGc+PZWulJCQVsXyBY4DWk9gLNz+GOprbH5kpJ++niqPNvBOItEV4f9Q
	jrOaJmE8R0RY84K0LubSnOzlqPnVYR1fiOej/lIA11QsXLF+1t1JWkE3leBOcRLcklOh7/MUyJ1
	hv6rn0zoLyCEEtpovz8PJVS5dZiYm5FYUFjuuNmOSfcZOXOnuJuI7EdAu6ShWhK/KPobZBFH3wm
	80Y12eG2VJEW+YzRL+tlI9OXsM1eoOpK6TyUqapzy5p79aMfjz3Lb3TTZwwqEQ9hwBIzzTlEROF
	i6zbNo8XeseRrLwI+Ew0jcj125rAjMXMl/iOumXb8edlMWoJJ8RIwRQujyQ1e9GNSW48F4RiWJV
	8BDiZ7FfhBv+Xz8KtkfYcdhP/1jB85DOhLKTwHxiiXnTDC44SXhdQaP7XxRcJh0Xkupg==
X-Received: by 2002:a05:6820:826:b0:6fb:b922:8d30 with SMTP id 006d021491bc7-6fbb922bb98mr4207627eaf.2.1792032102427;
        Wed, 14 Oct 2026 19:41:42 -0700 (PDT)
Received: from houminxi ([61.170.152.244])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-830385b9cb0sm16720024a34.4.2026.10.14.19.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 19:41:41 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: donald.hunter@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH net-next v3 0/2] netlink: specs: fill in the missing ovs operations
Date: Wed, 14 Oct 2026 22:41:29 -0400
Message-ID: <20261015024132.698658-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ovs specs describe get and new but not the set and del commands the
kernel has registered since the families were added. This series adds
them and names the attributes each handler reads. Nothing here changes
the kernel.

v3:
  - no change since v2 beyond the items listed above.

v2:
https://lore.kernel.org/netdev/20261012065552.2426415-1-houminxi@gmail.com/
  - ovs_flow new lists ufid-flags and probe, which ovs_flow_cmd_new()
    reads.
  - The commit message now says probe changes from binary to flag, and
    that new needs CAP_NET_ADMIN.
  - The key attribute doc no longer says a key is required for every
    request except a dump. get, set and del accept a ufid with no key,
    and only a new flow needs a key. A set that replaces the actions
    still needs a key.

v1:
https://lore.kernel.org/netdev/20261006130533.1620706-1-houminxi@gmail.com/
  - probe is a flag, matching the NLA_FLAG policy. A false flag is left
    out, where the binary attribute was sent empty.
  - del lists probe.
  - The set doc says replacing the actions needs a key even when a ufid
    is present.

Minxi Hou (2):
  netlink: specs: add ovs_flow del and set operations
  netlink: specs: add ovs datapath and vport set operations

 Documentation/netlink/specs/ovs_datapath.yaml | 18 +++++++
 Documentation/netlink/specs/ovs_flow.yaml     | 41 ++++++++++++++++++-
 Documentation/netlink/specs/ovs_vport.yaml    | 15 +++++++
 3 files changed, 72 insertions(+), 2 deletions(-)

Signed-off-by: Minxi Hou <houminxi@gmail.com>

base-commit: 05b5019b01fb9443b09ae4ed34af1135a80a84c8
-- 
2.56.0
