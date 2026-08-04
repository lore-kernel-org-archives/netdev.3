Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1C835AC37
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853535; cv=none; b=prniXa/eDrp5YIRAxX7I3+q+iRflLeFBk2rcqRDu/0zJ/9cR2+C4odvmZp9qoO/LGL3IiG42WeEfWiHq+RckWoSRhbh5I3hSD/lAp08a0BrziEuZ7cckBpebYqFiD8AclZye1vkcajlB/YbRcaOLAX59oTH5ECulIiDHIysQ0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853535; c=relaxed/simple;
	bh=MDGAkHHlRIhff1ANj/67CPpQ5jP+R+JdxKnBwIvyFFE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YTdqQA47LlVvptfq4ySKheMSbmkudH+nUVGQYAe4Iz2xoUYan0YZe77cpS86Vr+BoscWCRZuB0P69NK7uAR0jZl75hWPshY47i/Gs9GZmx16IshvMRmKcGjtvb5pKS3dUNx9AwA7z5BGpawmDCm9RMSyXeogNdT/hcks7cxDzyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgGRfwy+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgGRfwy+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 212CA1F000E9;
	Tue,  4 Aug 2026 14:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785853523;
	bh=cZTha9q5ZYgiPmJqb/0erQitqhdQIofMhjLsEUg9Hw0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UgGRfwy+pXdAaZD5mkm4c/B4AaowoRY/48wkzaKt1RUqmD9/XpF1Lt9F1tMo0wfgW
	 5bYfhLsRlgMhIdiE9Mjw2T9Brq49c/ngOm2O8q/lu3fq9m/v3EBUDvE4T/3ssa4wkl
	 Ubi0faXXm8xTHOy1K3h2DjBuGZ0Nzg0K9PCOxjcH8o/sN+/DLysxu5vt1yxhNf4EIz
	 sQ7ofdKmzgmPhDP1LLqmqUzWn71pvRZFQq1KoqBy1tAx9/msUgL2rLQm/BdWhvXiEq
	 +ncGtwrSEtWg4hQuBugXe2TTVFEE4Mi3D6gC3u9hwuepymO4xHaxEDPhHTIDBrW8PX
	 FT32aWnIMP45Q==
Date: Tue, 4 Aug 2026 07:25:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sheena Mohan <sheenamo@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 Willem de Bruijn <willemb@google.com>
Subject: Re: [TEST] google runner needs nested cases
Message-ID: <20260804072522.784ead37@kernel.org>
In-Reply-To: <CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
References: <20260721063829.7d9e6c7f@kernel.org>
	<CADWJPTsP=2=JFE9Oh5ym_wz4vROEFOCqa+dyCLRymyYLRB1BSg@mail.gmail.com>
	<20260723103607.55debff2@kernel.org>
	<CADWJPTs6G7zy+9aLxz9QD9Fk1szZK0b-vEFUm2jxTMtxt+t1uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jul 2026 10:07:15 -0700 Sheena Mohan wrote:
> The recent updates have been merged, and the tests should now report
> sub-case results.
> Please let us know if any further improvements are needed.

It doesn't look right.

https://gve-netdev-nipa.static.usercontent.goog/json/results-202608040108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a.json

test	"napi-threaded-py"
group	"selftests-drivers-net"
result	"pass"
^^^^^^^^^^^^^
link	"https://gve-netdev-nipa.static.usercontent.goog/results/202608040108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/napi-threaded-py/logs.html"
time	20.788391

# selftests: drivers/net: napi_threaded.py
not ok 1 selftests: drivers/net: napi_threaded.py # exit=1
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0
# not ok 1 napi_threaded.napi_init
# not ok 2 napi_threaded.change_num_queues
# not ok 3 napi_threaded.enable_dev_threaded_disable_napi_threaded

Does not look like a pass at all. Subcases not in JSON.
Not sure why the subcases are listed under the main return 
in the output, I've never seen that.


test	"psp-py"
group	"selftests-drivers-net"
result	"pass"
link	"https://gve-netdev-nipa.static.usercontent.goog/results/202608040108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/psp-py/logs.html"
time	341.833939

# selftests: drivers/net: psp.py
not ok 1 selftests: drivers/net: psp.py # exit=1
# Totals: pass:0 fail:1 xfail:0 xpass:0 skip:0 error:0

Again, doesn't seem to be a pass??


test	"queues-py"
group	"selftests-drivers-net"
result	"pass"
link	"https://gve-netdev-nipa.static.usercontent.goog/results/202608040108-88cb54ab-ca48-426b-9c9a-50bfbb0de32a/queues-py/logs.html"
time	686.483495
results	
	test	"queues-check-xsk"
	result	"pass"

Okay, here we have a subcase..

# selftests: drivers/net: queues.py
ok 1 selftests: drivers/net: queues.py
# Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
check_down
# ok 4 queues.check_xsk
# # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

But why only one? What happened to the other 3 that ksft clearly saw
since it enumerated check_xsk as the fourth??


Something is mangling the output on your runner, it seems.
And the parsing seems off.
