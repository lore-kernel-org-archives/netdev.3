Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA9298CA5
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599171; cv=none; b=aY409R/t+LGz9nd5wYN0/TFLe1BJKSPi1b2P626ZqQJebbKAQaL2bDRBH0EtxThr401qzRTmhjKugE+xrKNh1izDYYa+F1Or6wft3KM6vl5o6FnfkaP7j+gfh07+frMdUnb7tdsIVhg4QzkFbF+f7j6zAinOqfiPdw1nHy0xDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599171; c=relaxed/simple;
	bh=MgtimNvGMW2jV2lLmKB4kJ0Nlw52AMVJCUyriCjAvEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sMkjbYCDZyrghIURCS2fpzOm6YQ/nkjre2G2h+m6s7loMFMDZc7Ns2YaqrrAplbdPSVo4E5Xb+ka073pWRZCe9TTc9d+Qm5OIjyY/9jljCz1hFh8z7zUpbfzpqTNwcltzAjG83bdR1ird7X5BZoAfDZyOydw2F14qbtfWyorfAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UsvN7/EZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aE1xUX6V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UsvN7/EZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE1xUX6V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790599168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MgtimNvGMW2jV2lLmKB4kJ0Nlw52AMVJCUyriCjAvEs=;
	b=UsvN7/EZabJ7NxiSaQG1/9+sNZuw12e6sEXUnQexXWjOoSVVo/QHQXeFAJeOpmayMleeZp
	boO80nEecGC78f11gLfxXhL4PLsQLdPerumhPn6c5ICvtruuOJTUy+hrrY5b256CgoLz38
	hmTn5cmDdw8OSF5yxzx+UUv3YVEARX4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-5o0p2zcoNm-iQ_YY5FXOWg-1; Mon, 28 Sep 2026 08:39:27 -0400
X-MC-Unique: 5o0p2zcoNm-iQ_YY5FXOWg-1
X-Mimecast-MFC-AGG-ID: 5o0p2zcoNm-iQ_YY5FXOWg_1790599166
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a009f82bedso3406595e9.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790599166; x=1791203966; darn=vger.kernel.org;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MgtimNvGMW2jV2lLmKB4kJ0Nlw52AMVJCUyriCjAvEs=;
        b=aE1xUX6VyovX1pT8WuVqoKVtOA4eW81XFMph5oQ3cXySovirXqsZj3Dp57GFUI2DOI
         5SJC3hOKLVvC1z8S/LVyWwx2Fd3kWirrSFR+ZQuDcFylImDVtf2WUProKrxsZo0IpEIC
         XiNftDJQsqHhida/pZaoc1rPLqj4EqV4x7m3EzE0fv895jjjyavM+qXJQjGI/75r//le
         gaXD3b737C/ZtU7EGUcC1mxxg592vZ43Ngu6povcxj2ONze81jBWHOUnMFVEH/vjOygq
         ZRM7cerZVnRMfAdrkPIYG/LqROEWeZovG1C4nkReEY6hZhKjUsE7kO81AKXQ1uY6LfGa
         cIwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790599166; x=1791203966;
        h=content-type:mime-version:user-agent:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MgtimNvGMW2jV2lLmKB4kJ0Nlw52AMVJCUyriCjAvEs=;
        b=zP7IxxYGVmqHmsXFFZRC1D3T2A430aMQUvNjlnrhcjqwE+kY6MoICUFvh36y2g2Hny
         uj3r67QL6hk5BxqqxkrHuZioowhL0L1+XIQCVUFDeceriDjdpEcjLxzG4C88mRDKrQWW
         ioWZ6xAaMIVXGbmr79s4NxQGk9yhCmgcTbFkeLULBEowfeB39r+MwrEFG8KJtRkypiXy
         XsrHlfhjaIEz2SDYlHtA32a7RdDGowli628Np7MNDxhxT2bZkU1qvG7EEy/Ncb81aGob
         5Vhw7w3ddOPo9M7fC1kH3POPoXYppMhB+qRyn8EkH3AtS4s6nH7SuBPvdYH5hdsERRFC
         tMpg==
X-Gm-Message-State: AFuF++kWXLmRABSQZ9KI1oxijAJ463swuYvOIdgF+niSgznoS/WrVyD7
	5E+oTNDhJHQ3Dg8ERH5cbkAGHO4qMnPC3WVAJEQ239BEg+pucg/1j4iY2Uv5ZwrxNwvpIgLJh8W
	APWy4FrVPAB71nMxc2RmGEbDFtS0LbYmlNX5V4WttfpSW0aYfr4Y1R4nX7A==
X-Gm-Gg: AYBFou16kSnLBPTBrfgTqOJLxXomU78D968lv5BxJBVIw1s2x/w/7MUMQ37j/5eEsyi
	hWNgklOQL/6XqEPLlW4Pz3pcsjdZbG3s/Iuaji6WxOJj6GV2nm/bnGLGID55lH//Ym6c+rkd4yB
	fhT9w0lI9Di3qBMeNP9zysrtEg8wNyNfthsbRgI0GQ3MwNHmMTg26gsfAcGMu+InXewdcDHOPeH
	4FIW/Wtsxn+I+lR+DLfmuKdjLnfKkeRZ8ovwnwrkPG62Nsqkb9hyvRCApBjpgYCsHNJ7ru7o8n8
	zOsHAmuM3T2dP2PSaKzrleBrZjWlC95nAAzrHJDLtv6sdVXoNcyrMWn0yHoeSrMlaJeUcbvBGTn
	SIJ3ndRg9ZRqZgy1/nt4ahWx8HZjA2Zc=
X-Received: by 2002:a05:600d:8643:10b0:49f:bb8a:b4ce with SMTP id 5b1f17b1804b1-49fe67bc26fmr163681905e9.28.1790599165802;
        Mon, 28 Sep 2026 05:39:25 -0700 (PDT)
X-Received: by 2002:a05:600d:8643:10b0:49f:bb8a:b4ce with SMTP id 5b1f17b1804b1-49fe67bc26fmr163681685e9.28.1790599165460;
        Mon, 28 Sep 2026 05:39:25 -0700 (PDT)
Received: from aconole-thinkpadt14gen4.rmtusnh.csb ([24.151.142.216])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c076dc3sm1269605e9.0.2026.09.28.05.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 05:39:24 -0700 (PDT)
From: Aaron Conole <aconole@redhat.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org,  Eelco Chaudron <echaudro@redhat.com>,  Ilya
 Maximets <i.maximets@ovn.org>,  "David S . Miller" <davem@davemloft.net>,
  Eric Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,
  Paolo Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Shuah
 Khan <shuah@kernel.org>,  dev@openvswitch.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 1/2] selftests/net/openvswitch: add SCTP
 flow key test over IPv6
In-Reply-To: <20260918144647.2024095-2-houminxi@gmail.com> (Minxi Hou's
	message of "Fri, 18 Sep 2026 10:46:46 -0400")
References: <20260918144647.2024095-1-houminxi@gmail.com>
	<20260918144647.2024095-2-houminxi@gmail.com>
Date: Mon, 28 Sep 2026 08:39:17 -0400
Message-ID: <f7tmrt18s96.fsf@aconole-thinkpadt14gen4.rmtusnh.csb>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Minxi Hou <houminxi@gmail.com> writes:

> The merged SCTP test covers only IPv4. The SCTP branch of the IPv6
> extractor (the proto=132 walk after parse_ipv6hdr) and the v6 side of
> the SCTP netlink validation (match_validate() requires the sctp() key
> whenever ipv6(proto=132) is matched) have no selftest coverage.
>
> Add test_sctp_connect_v6 mirroring the v4 test: bare icmpv6() flows
> forward NS/NA, and ipv6(proto=132),sctp(dst=4443)/sctp(src=4443)
> flows gate the association in the same three phases (flows installed,
> removed, reinstalled). A keyless ipv6(proto=132) install must be
> refused with EINVAL, pinning the reject side of the match_validate()
> rule; without it a regression dropping the requirement would pass
> unnoticed. The refusal is asserted to be EINVAL specifically, not a
> parse error of the flow string. After the association succeeds the
> test also pushes a known payload across and waits for the listener
> to log it, proving the datapath carries the association's traffic
> end to end, not only its handshake. Skips when the sctp module is
> missing, socat lacks SCTP or IPv6 support, or IPv6 is unavailable;
> an association or payload failure with the flows installed fails
> the test.
>
> Signed-off-by: Minxi Hou <houminxi@gmail.com>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>

