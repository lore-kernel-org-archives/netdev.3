Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792748101;
	b=nEQZtQfQrbgYAcHBSXmAYTlnsSKrVe8Jr4VB/2uIOTlvs/3mZeOVad0E3p0FG9OekKtA
	 cksxDgdD1k6ay5LZBbGtQTl6y6j+K7jfoXDgLtHkXoX5bUkeK6ViZNDaw7tqAvR9DYAw3
	 1aMtbl9vcnkck9y2HOjnduvDZh3VapV0YSK2V6XVWqDCcTuCzux1UvDRP7wJ55APf3LjC
	 HFoZosjCVI6CCkOzXydBoNByV+ZzQ9ID961KB0a5URZdUS9Oj4Hn8LYNLQjeADdNO5kgH
	 uzWZ6ZYHCUgL9xkXY0P6Ze7VQ8Kv9BRKixViFMdZcfXK4YmNaI9UKtpw5Zb2nkps3+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792748101;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Transfer-Encoding:X-Scanned-By;
	bh=VLPx9daPRJHjWlFmv44h49kyUIjBxH+IthNyy+HLrTc=;
	b=PrkMJA7QQW8jW04AkDUEGgZ5AISIppUBk5UObNGwNo7TI9Mdr7/ZeQo4Aa5fcF/Ue/CT
	 RkejVYC9EUUbo8AvNmnqxppHHlxOr5qeksBmv59aFy7yVdM0SMbTK/5odrbvxJ6b45FwO
	 fnlVHBLvQo5Fn+5DSrj+xIRHSg4+H+9pq6cqt6jPa4wWogNlSXa5PYXXOIwrRUs0PCHqI
	 9xWwWb7560bDmMVFroBvQyI21tGX2zXZC7ggIUA4P51Bhc2X530TWOUcpgiuKntf7Mp5s
	 hca19yu+YQyg1ftlpBarPejhfY54XwvVS9S36RfakUSUAtsgfBHAqBve4sD355YOe+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OZx2LRBL;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF505606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 09:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF505606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OZx2LRBL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792748099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=VLPx9daPRJHjWlFmv44h49kyUIjBxH+IthNyy+HLrTc=;
	b=OZx2LRBL7IFaW2zAGLLVHNi2iFioJlV7p2MNT0X0RXzWLRT2xCKAOzulCci1yp/QyK6GnZ
	rfS6I2obDDSUhIZLoDXYKS4kSr+pSGdXyMtz+d5CWaOvA2n0h76WYz+n5I94TQso+Tj34U
	QNaQO3S6xGICROMDeIG2FQg3no/EasY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-SF_5dlO9P2anwyf-QaezNQ-1; Fri,
 23 Oct 2026 05:34:56 -0400
X-MC-Unique: SF_5dlO9P2anwyf-QaezNQ-1
X-Mimecast-MFC-AGG-ID: SF_5dlO9P2anwyf-QaezNQ_1792748095
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 20C631954124;
	Fri, 23 Oct 2026 09:34:55 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3C713195608C;
	Fri, 23 Oct 2026 09:34:54 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: mkubecek@suse.cz
Subject: [PATCH ethtool] COPYING: sync GPL-2.0 text with the current FSF version
Date: Fri, 23 Oct 2026 11:34:52 +0200
Message-ID: <20261023093452.628061-1-ivecera@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Update COPYING to match the GPL-2.0 text currently published by the FSF
at https://www.gnu.org/licenses/old-licenses/gpl-2.0.txt. The FSF has
replaced its obsolete postal address with web URLs and renamed the
sample signatory in the appendix from "Ty Coon" to "Moe Ghoul".

The license terms themselves are unchanged.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 COPYING | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/COPYING b/COPYING
index d159169d1050..9efa6fbc9628 100644
--- a/COPYING
+++ b/COPYING
@@ -2,7 +2,7 @@
                        Version 2, June 1991
 
  Copyright (C) 1989, 1991 Free Software Foundation, Inc.,
- 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ <https://fsf.org/>
  Everyone is permitted to copy and distribute verbatim copies
  of this license document, but changing it is not allowed.
 
@@ -304,8 +304,7 @@ the "copyright" line and a pointer to where the full notice is found.
     GNU General Public License for more details.
 
     You should have received a copy of the GNU General Public License along
-    with this program; if not, write to the Free Software Foundation, Inc.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+    with this program; if not, see <https://www.gnu.org/licenses/>.
 
 Also add information on how to contact you by electronic and paper mail.
 
@@ -329,8 +328,8 @@ necessary.  Here is a sample; alter the names:
   Yoyodyne, Inc., hereby disclaims all copyright interest in the program
   `Gnomovision' (which makes passes at compilers) written by James Hacker.
 
-  <signature of Ty Coon>, 1 April 1989
-  Ty Coon, President of Vice
+  <signature of Moe Ghoul>, 1 April 1989
+  Moe Ghoul, President of Vice
 
 This General Public License does not permit incorporating your program into
 proprietary programs.  If your program is a subroutine library, you may
-- 
2.56.0

