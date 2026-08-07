Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA331A9F97
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 23:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786146438; cv=none; b=cHRDStO4uceuCfEDgbQRtzVhucpQKJ1DXccmnQOE5IbUgLCjlAVV4p6Gxo+EB2OKqcwJYouNaowINVtLb64ljEubnt5s+Z/Oa9kJibwv11dRbCf0aGRnY3zXz+wjT9A2Fdw4eAWzgPidRM96LobdCva7zh9ZmWWvnZ8wt57Il+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786146438; c=relaxed/simple;
	bh=563G7j5dD/vO88sWLEPTKrJ1JTde4jg3trFvUTSxbaA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eNK5sC3ceSE/4XXhHZKDIMu/VZu5kvpc3omf0m7MQeqmUW+3Q5PZosdqxZnK2JVg6QLxb3CWTY82JvRrMyzbHYZwoRM4pEzipMULUdk8y1vB0JEBPyOnjt2TI6vhJzicMHtARAjmnKqOMAdbh7VPfgw0FfhFVuyYSl7yXwJbQes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o+rZxZjU; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+rZxZjU"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66899c7b57bso83466d50.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 16:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786146436; x=1786751236; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6U8b/xxr7W7JidExED8zlCpMLvLV8fhTwg1OshGKUyU=;
        b=o+rZxZjUvxLe7+h+kZRkMvo342clZXsHKgGXvxVWj4eRCpYxN+ekEfiLc+c+nMOcOW
         Kc6+fIo87Qf7+5ebUQ+uVbGvlqXQb/U0fn6qoge0EVextBzEoJt8FdPjda0WBarmRQHJ
         NlxhxGQKekNVa4JVIHHgeavEtdHpUVbPas+yfmHhaSVSc7j9k8inlNIuPfuQGmTZep2m
         WTIkzLoeyj+wqcRdCXhRBKUFbr4KYm0fST77ibY5QMVx21Y9LAMEvv2ovq3UyTfL8mCW
         wG1KsFFroNtAZag47GqJQsIiIZXE/x/M4iBZxcDQryUT0KvnxSIXiSXRZ9xE76jx2UJN
         3+Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786146436; x=1786751236;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6U8b/xxr7W7JidExED8zlCpMLvLV8fhTwg1OshGKUyU=;
        b=tJWiIR19YPI5TLYMuatGtDRm3ZWe2CvlF9XxnZcp9fUlczCbKOz9I18CzaL5kRLXPx
         bY2MT2HTJeKDfgZJZ+4joVyspP9OZKX7Cnt9Pehxbj0gzGMfI8pq74+ZsxJFX5NWdqEc
         h64f6DZNtjxshIkf5vVq4gGR8/snl2Wn6X8KTRoNDBafAcGzitC7X5nEvumqUJgqM610
         Js73O69RIA+LFkjLecMX7FtApJG+x5ch78bd2Y6hGrqKe8v92hGFaL0sPU/nXLse88sv
         2KyjhZkB2JM88NqwBOYrLUYqIwWyApW5n7eIfyPu+MNoh5dy6VsmE5ptcOMxCYyH52EI
         FpPA==
X-Gm-Message-State: AOJu0YwvKSctqLZhz6Tj2Q/4WFCAi+bfNIap6ssVXm1gWiGpx7Vpy3qp
	M1nO5B1b/ZtKRfsy136c+tm8u+iH0Aec03O3hjgu63TSCZrbreiXJJxW
X-Gm-Gg: AR+sD13Q3PWpuo7OuDagV9PO+REDadYoBKTUDhaQ+DYr21hzeN5oVfrmsPGhp6mbMon
	YEdAvqZ4Y2m4HLew16YEOpT1ClcHLvyo+j3OlHIrkXubyoCnfQuEM5ph08E7CasiEpsJYHdc6Ad
	7FDRhfFvgznJroUXE2g/mge3WCguuI8OsQVTbROThkaw12RqRtuJNM428omdQcHbGJrdbZw1boj
	WXMR39bEO6a4JSNrxX5Wmjlccdy95aITcjx36KW+zzztOfcNL++FNrXY+kJ5bSwdeFz08rCifHi
	EPBS61dhv7rqI/tRzoK/aaOu1CfUbutFJmboFzJ0BQXkUNy72ROFgwwvX73F6qDWGrEORQQLhqg
	Pf04iXm7pa+tDOoZsY+RplWg+cjJAv68cH7aN0ffklW8ohAxJ6c21t8A8yfgKr7QD+/ks5SxvWd
	sG/jxSm2vixZrmQa0xyDpS3Qmj18oTFtXlYaz2ljijCAqQSrPMS3BJNgpDaAI7fGMgBDpmYuGv2
	Fqc6VmYVxoW/fB5qSnnVjx+f6XcAUalWVLRi+ffmqkVzYU=
X-Received: by 2002:a05:690c:6802:b0:81e:ad1:8e5b with SMTP id 00721157ae682-820224f293amr156718137b3.33.1786146435971;
        Fri, 07 Aug 2026 16:47:15 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-823f03c85fdsm19233987b3.11.2026.08.07.16.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 16:47:15 -0700 (PDT)
Date: Fri, 07 Aug 2026 19:47:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 intel-wired-lan@lists.osuosl.org, 
 anthony.l.nguyen@intel.com, 
 joshua.a.hay@intel.com, 
 przemyslaw.kitszel@intel.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.342b45ed25289@gmail.com>
In-Reply-To: <20260807153933.7b8b01d4@kernel.org>
References: <20260806232913.4020403-1-willemdebruijn.kernel@gmail.com>
 <willemdebruijn.kernel.c36ea46d8e97@gmail.com>
 <20260807153933.7b8b01d4@kernel.org>
Subject: Re: [PATCH net-next v4 0/6] hardware pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 06 Aug 2026 21:18:37 -0400 Willem de Bruijn wrote:
> > This was intended to have a wider audience list. Will address in v5.
> 
> LGTM FWIW

Good to know thanks!

I will fix up a kdoc warning that patchwork pointed out.
